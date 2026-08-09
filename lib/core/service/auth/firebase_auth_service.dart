import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/security/nonce_generator.dart';
import 'package:lifeclient/core/service/analytics/analytics_service.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/core/service/auth/google_sign_in_service.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/credential_result.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';
import 'package:lifeclient/product/model/auth/sign_in_result.dart';
import 'package:lifeclient/product/model/auth/user/firebase_user_extension.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class FirebaseAuthService implements AuthService {
  FirebaseAuthService({
    required CustomFirestoreService firestoreService,
    required ProductCache productCache,
    required AnalyticsService analyticsService,
    FirebaseAuth? auth,
    GoogleSignInService? googleSignInService,
    NonceGenerator? nonceGenerator,
  }) : _firestoreService = firestoreService,
       _productCache = productCache,
       _analyticsService = analyticsService,
       _auth = auth ?? FirebaseAuth.instance,
       _googleSignInService = googleSignInService ?? GoogleSignInService(),
       _nonceGenerator = nonceGenerator ?? const NonceGenerator();

  final CustomFirestoreService _firestoreService;
  final ProductCache _productCache;
  final AnalyticsService _analyticsService;
  final FirebaseAuth _auth;
  final GoogleSignInService _googleSignInService;
  final NonceGenerator _nonceGenerator;

  /// The user doc is written by the auth-state listener, not by [signIn], so
  /// the sign-in call has to wait for it. Without a ceiling that wait is
  /// unbounded and the button stays in its loading state forever.
  static const _sessionTimeout = Duration(seconds: 30);

  final StreamController<UserModel?> _userController =
      StreamController<UserModel?>.broadcast();
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _docSubscription;

  /// Apple hands the person's name back only on the very first authorization,
  /// and never puts it on the Firebase user. It is parked here so the doc
  /// created moments later by [_ensureUserDoc] can still pick it up.
  String? _pendingDisplayName;

  @override
  Stream<UserModel?> get userStream {
    _authSubscription ??= _auth.authStateChanges().listen(_onAuthChanged);
    return _userController.stream;
  }

  @override
  UserModel? get cachedUser {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    return _productCache.userCache.get(uid);
  }

  @override
  Future<SignInResult> signIn(AuthProvider provider) async {
    try {
      final AuthCredential credential;
      switch (await _credentialFor(provider)) {
        case CredentialCancelled():
          return const SignInCancelled();
        case CredentialFailed(:final error, :final stackTrace):
          return await _failure(provider, error, stackTrace);
        case CredentialReady(credential: final ready):
          credential = ready;
      }

      final sessionResult = userStream.first.timeout(_sessionTimeout);
      final result = await _auth.signInWithCredential(credential);
      if (result.user == null) {
        return const SignInFailure(SignInError.unknown);
      }
      final user = await sessionResult;
      if (user == null) return const SignInFailure(SignInError.unknown);
      return SignInSuccess(
        user,
        isNewUser: result.additionalUserInfo?.isNewUser ?? false,
      );
    } on Object catch (error, stackTrace) {
      return _failure(provider, error, stackTrace);
    } finally {
      _pendingDisplayName = null;
    }
  }

  Future<SignInResult> _failure(
    AuthProvider provider,
    Object error,
    StackTrace stackTrace,
  ) async {
    final reason = _reasonFor(error);
    CustomLogger.showError<void>(error);
    _analyticsService.recordError(
      error,
      stackTrace,
      reason: 'signIn(${provider.name}) -> ${reason.name}: ${_codeOf(error)}',
    );
    await signOut();
    return SignInFailure(reason);
  }

  SignInError _reasonFor(Object error) => switch (error) {
    FirebaseAuthException(:final code) => switch (code) {
      'account-exists-with-different-credential' =>
        SignInError.accountExistsWithDifferentCredential,
      'invalid-credential' ||
      'invalid-verification-code' ||
      'invalid-verification-id' => SignInError.invalidCredential,
      'operation-not-allowed' => SignInError.providerDisabled,
      'user-disabled' => SignInError.userDisabled,
      'network-request-failed' => SignInError.network,
      _ => SignInError.unknown,
    },
    SignInWithAppleNotSupportedException() => SignInError.unsupported,
    SignInWithAppleCredentialsException() => SignInError.invalidCredential,
    SignInWithAppleAuthorizationException(:final code) => switch (code) {
      AuthorizationErrorCode.invalidResponse ||
      AuthorizationErrorCode.failed => SignInError.invalidCredential,
      _ => SignInError.unknown,
    },
    TimeoutException() || SocketException() => SignInError.network,
    PlatformException(:final code) when code == 'network_error' =>
      SignInError.network,
    _ => SignInError.unknown,
  };

  /// The provider-specific code, kept verbatim for Crashlytics — the mapped
  /// [SignInError] is deliberately coarse and loses the detail needed to tell
  /// two failures apart after the fact.
  String _codeOf(Object error) => switch (error) {
    FirebaseAuthException(:final code) => code,
    SignInWithAppleAuthorizationException(:final code, :final message) =>
      '${code.name} / $message',
    PlatformException(:final code) => code,
    _ => error.runtimeType.toString(),
  };

  @override
  Future<void> signOut() async {
    await _stopWatchingUserDoc();
    final uid = _auth.currentUser?.uid;
    try {
      await Future.wait([_googleSignInService.signOut(), _auth.signOut()]);
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
    }
    if (uid != null) _productCache.userCache.delete(UserModel(uid: uid));
  }

  Future<void> dispose() async {
    await _stopWatchingUserDoc();
    await _authSubscription?.cancel();
    _authSubscription = null;
    await _userController.close();
  }

  Future<void> _onAuthChanged(User? user) async {
    await _stopWatchingUserDoc();
    if (user == null) {
      _userController.add(null);
      return;
    }
    final ensured = await _ensureUserDoc(user);
    if (_auth.currentUser?.uid != user.uid) return;
    if (!ensured) {
      await signOut();
      return;
    }
    _docSubscription = CollectionPaths.users.collection
        .doc(user.uid)
        .snapshots()
        .listen(
          (snapshot) => _onUserDocChanged(user, snapshot),
          onError: (Object error) => CustomLogger.showError<void>(error),
        );
  }

  Future<void> _stopWatchingUserDoc() async {
    await _docSubscription?.cancel();
    _docSubscription = null;
  }

  Future<void> _onUserDocChanged(
    User user,
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) async {
    if (!snapshot.exists) {
      await signOut();
      return;
    }
    final model = const UserModel.empty().fromFirebase(snapshot);
    _productCache.userCache.update(model);
    await _refreshTokenIfPermissionsChanged(user, model);
    _userController.add(model);
  }

  Future<bool> _ensureUserDoc(User user) async {
    try {
      final snapshot = await CollectionPaths.users.collection
          .doc(user.uid)
          .get(const GetOptions(source: Source.server))
          .timeout(_firestoreService.timeoutDuration);
      if (snapshot.exists) return true;
      final displayName = _pendingDisplayName;
      if (displayName != null) await _adoptDisplayName(user, displayName);
      final result = await _firestoreService.insertWithID(
        path: CollectionPaths.users,
        model: user.toUserModel(displayNameOverride: displayName),
        key: user.uid,
      );
      return result.isSuccess;
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return false;
    }
  }

  /// Mirrors the name onto the Firebase user so later sessions — which Apple
  /// answers with no name at all — still have one to fall back on.
  Future<void> _adoptDisplayName(User user, String displayName) async {
    try {
      await user.updateDisplayName(displayName);
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
    }
  }

  Future<void> _refreshTokenIfPermissionsChanged(
    User user,
    UserModel model,
  ) async {
    try {
      final tokenResult = await user.getIdTokenResult();
      final claimPermissions =
          (tokenResult.claims?['permissions'] as List?)?.cast<int>() ??
          const <int>[];
      if (_samePermissions(claimPermissions, model.permissions)) return;
      await user.getIdToken(true);
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
    }
  }

  bool _samePermissions(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    final other = b.toSet();
    return a.every(other.contains);
  }

  Future<CredentialResult> _credentialFor(AuthProvider provider) =>
      switch (provider) {
        AuthProvider.google => _googleSignInService.credential(),
        AuthProvider.apple => _appleCredential(),
      };

  Future<CredentialResult> _appleCredential() async {
    // Apple, hash'lenmiş nonce'u identityToken'ın içine gömüyor; Firebase
    // rawNonce'u kendi hash'leyip karşılaştırıyor (token replay'e karşı).
    final rawNonce = _nonceGenerator.generate();
    final hashedNonce = _nonceGenerator.sha256Hex(rawNonce);

    final AuthorizationCredentialAppleID appleCredential;
    try {
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );
    } on SignInWithAppleAuthorizationException catch (error, stackTrace) {
      if (error.code == AuthorizationErrorCode.canceled) {
        return const CredentialCancelled();
      }
      return CredentialFailed(error, stackTrace);
    } on Object catch (error, stackTrace) {
      return CredentialFailed(error, stackTrace);
    }

    final identityToken = appleCredential.identityToken;
    if (identityToken == null) {
      return CredentialFailed(
        const SignInWithAppleCredentialsException(
          message: 'Apple returned no identity token',
        ),
        StackTrace.current,
      );
    }

    _pendingDisplayName = _appleDisplayName(appleCredential);
    // AppleAuthProvider rather than OAuthProvider on purpose: the iOS plugin
    // switches on signInMethod, and OAuthProvider stamps `oauth`, which misses
    // the apple.com branch and builds the credential through the generic
    // `credentialWithProviderID:` instead of Apple's own
    // `appleCredentialWithIDToken:rawNonce:fullName:`. This path also carries
    // the name natively, so Firebase fills the auth profile itself.
    return CredentialReady(
      AppleAuthProvider.credentialWithIDToken(
        identityToken,
        rawNonce,
        AppleFullPersonName(
          givenName: appleCredential.givenName,
          familyName: appleCredential.familyName,
        ),
      ),
    );
  }

  String? _appleDisplayName(AuthorizationCredentialAppleID credential) {
    final parts = [credential.givenName, credential.familyName]
        .whereType<String>()
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty);
    return parts.isEmpty ? null : parts.join(' ');
  }
}

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/analytics/analytics_service.dart';
import 'package:lifeclient/core/service/auth/apple_sign_in_service.dart';
import 'package:lifeclient/core/service/auth/auth_credential_provider.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/core/service/auth/google_sign_in_service.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/credential_result.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';
import 'package:lifeclient/product/model/auth/sign_in_result.dart';
import 'package:lifeclient/product/model/auth/user/firebase_user_extension.dart';

final class FirebaseAuthService implements AuthService {
  FirebaseAuthService({
    required CustomFirestoreService firestoreService,
    required ProductCache productCache,
    required AnalyticsService analyticsService,
    FirebaseAuth? auth,
    AuthCredentialProvider? googleProvider,
    AuthCredentialProvider? appleProvider,
  }) : _firestoreService = firestoreService,
       _productCache = productCache,
       _analyticsService = analyticsService,
       _auth = auth ?? FirebaseAuth.instance,
       _googleProvider = googleProvider ?? GoogleSignInService(),
       _appleProvider = appleProvider ?? AppleSignInService();

  final CustomFirestoreService _firestoreService;
  final ProductCache _productCache;
  final AnalyticsService _analyticsService;
  final FirebaseAuth _auth;
  final AuthCredentialProvider _googleProvider;
  final AuthCredentialProvider _appleProvider;

  /// The user doc is written by the auth-state listener, not by [signIn], so
  /// the sign-in call has to wait for it. Without a ceiling that wait is
  /// unbounded and the button stays in its loading state forever.
  static const _sessionTimeout = Duration(seconds: 30);

  final StreamController<UserModel?> _userController =
      StreamController<UserModel?>.broadcast();
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _docSubscription;

  /// Written by [signIn] from the credential result and read by
  /// [_ensureUserDoc], which the auth-state listener reaches on its own — the
  /// name cannot simply be returned down the call stack.
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
      switch (await _providerFor(provider).credential()) {
        case CredentialCancelled():
          return const SignInCancelled();
        case CredentialFailed(:final error, :final stackTrace, :final reason,
            :final code):
          return await _fail(
            provider,
            error,
            stackTrace,
            reason: reason,
            code: code,
          );
        case CredentialReady(credential: final ready, :final displayName):
          credential = ready;
          _pendingDisplayName = displayName;
      }

      final sessionResult = userStream.first.timeout(_sessionTimeout);
      final result = await _auth.signInWithCredential(credential);
      if (result.user == null) {
        return await _defect(provider, 'signInWithCredential returned no user');
      }
      final user = await sessionResult;
      if (user == null) {
        return await _defect(provider, 'auth session produced no user');
      }
      return SignInSuccess(
        user,
        isNewUser: result.additionalUserInfo?.isNewUser ?? false,
      );
    } on Object catch (error, stackTrace) {
      return _fail(
        provider,
        error,
        stackTrace,
        reason: _reasonFor(error),
        code: _codeOf(error),
      );
    } finally {
      _pendingDisplayName = null;
    }
  }

  Future<SignInResult> _fail(
    AuthProvider provider,
    Object error,
    StackTrace stackTrace, {
    required SignInError reason,
    required String code,
  }) async {
    CustomLogger.showError<void>(error);
    _analyticsService.recordError(
      error,
      stackTrace,
      reason: 'signIn(${provider.name}) -> ${reason.name}: $code',
    );
    await signOut();
    return SignInFailure(reason);
  }

  /// Firebase accepted the credential but produced no user. Nothing the person
  /// did causes this, so it is reported rather than shown as a plain failure.
  Future<SignInResult> _defect(AuthProvider provider, String message) => _fail(
    provider,
    StateError(message),
    StackTrace.current,
    reason: SignInError.unknown,
    code: message,
  );

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
    TimeoutException() || SocketException() => SignInError.network,
    PlatformException(:final code) when code == 'network_error' =>
      SignInError.network,
    _ => SignInError.unknown,
  };

  String _codeOf(Object error) => switch (error) {
    FirebaseAuthException(:final code) => code,
    PlatformException(:final code) => code,
    _ => error.runtimeType.toString(),
  };

  @override
  Future<void> signOut() async {
    await _stopWatchingUserDoc();
    final uid = _auth.currentUser?.uid;
    try {
      await Future.wait([
        ..._providers.map((provider) => provider.signOut()),
        _auth.signOut(),
      ]);
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

  AuthCredentialProvider _providerFor(AuthProvider provider) =>
      switch (provider) {
        AuthProvider.google => _googleProvider,
        AuthProvider.apple => _appleProvider,
      };

  /// Derived from [AuthProvider] rather than listed by hand, so a new provider
  /// cannot be added without [_providerFor] failing to compile — and once it
  /// compiles, [signOut] already covers it.
  Iterable<AuthCredentialProvider> get _providers =>
      AuthProvider.values.map(_providerFor);
}

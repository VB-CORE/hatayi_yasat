import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/security/nonce_generator.dart';
import 'package:lifeclient/core/service/analytics/analytics_service.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_result.dart';
import 'package:lifeclient/product/model/auth/user/firebase_user_extension.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class FirebaseAuthService implements AuthService {
  FirebaseAuthService({
    required CustomFirestoreService firestoreService,
    required ProductCache productCache,
    required AnalyticsService analyticsService,
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    NonceGenerator? nonceGenerator,
  }) : _firestoreService = firestoreService,
       _productCache = productCache,
       _analyticsService = analyticsService,
       _auth = auth ?? FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
       _nonceGenerator = nonceGenerator ?? const NonceGenerator();

  final CustomFirestoreService _firestoreService;
  final ProductCache _productCache;
  final AnalyticsService _analyticsService;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final NonceGenerator _nonceGenerator;

  static const _appleProviderId = 'apple.com';

  final StreamController<UserModel?> _userController =
      StreamController<UserModel?>.broadcast();
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _docSubscription;
  Future<void>? _googleInitialization;

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
      final credential = await _credentialFor(provider);
      if (credential == null) return const SignInCancelled();
      final sessionResult = userStream.first;
      final result = await _auth.signInWithCredential(credential);
      if (result.user == null) return const SignInFailure();
      final user = await sessionResult;
      if (user == null) return const SignInFailure();
      return SignInSuccess(
        user,
        isNewUser: result.additionalUserInfo?.isNewUser ?? false,
      );
    } on Object catch (error, stackTrace) {
      CustomLogger.showError<void>(error);
      _analyticsService.recordError(
        error,
        stackTrace,
        reason: 'signIn(${provider.name})',
      );
      await signOut();
      return const SignInFailure();
    }
  }

  @override
  Future<void> signOut() async {
    await _stopWatchingUserDoc();
    final uid = _auth.currentUser?.uid;
    try {
      await Future.wait([_googleSignIn.signOut(), _auth.signOut()]);
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
      final result = await _firestoreService.insertWithID(
        path: CollectionPaths.users,
        model: user.toUserModel(),
        key: user.uid,
      );
      return result.isSuccess;
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return false;
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

  Future<AuthCredential?> _credentialFor(AuthProvider provider) =>
      switch (provider) {
        AuthProvider.google => _googleCredential(),
        AuthProvider.apple => _appleCredential(),
      };

  /// google_sign_in 7 requires a one-time initialize() before authenticate().
  /// A failed attempt is discarded so the next sign-in can retry.
  Future<void> _ensureGoogleInitialized() async {
    final pending = _googleInitialization ??= _googleSignIn.initialize();
    try {
      await pending;
    } on Object {
      _googleInitialization = null;
      rethrow;
    }
  }

  Future<AuthCredential?> _googleCredential() async {
    await _ensureGoogleInitialized();

    final GoogleSignInAccount googleUser;
    try {
      googleUser = await _googleSignIn.authenticate();
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
    return GoogleAuthProvider.credential(
      idToken: googleUser.authentication.idToken,
    );
  }

  Future<AuthCredential?> _appleCredential() async {
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
    } on SignInWithAppleAuthorizationException catch (error) {
      if (error.code == AuthorizationErrorCode.canceled) return null;
      rethrow;
    }

    final identityToken = appleCredential.identityToken;
    if (identityToken == null) return null;
    return OAuthProvider(_appleProviderId).credential(
      idToken: identityToken,
      rawNonce: rawNonce,
    );
  }
}

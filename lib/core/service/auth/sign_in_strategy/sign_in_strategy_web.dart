import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_auth/firebase_auth.dart' as firebase show AuthProvider;
import 'package:flutter/foundation.dart';
import 'package:lifeclient/core/service/auth/sign_in_error_mapper.dart';
import 'package:lifeclient/core/service/auth/sign_in_strategy/sign_in_strategy.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_attempt.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

final class PlatformSignInStrategy implements SignInStrategy {
  PlatformSignInStrategy({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  static const _cancelCodes = {
    'popup-closed-by-user',
    'cancelled-popup-request',
    'user-cancelled',
    'redirect-cancelled-by-user',
  };

  static const _popupBlocked = 'popup-blocked';

  static const _redirectGrace = Duration(seconds: 5);

  static const _errors = SignInErrorMapper();

  @override
  Future<SignInAttempt> signIn(
    AuthProvider provider, {
    required ValueSetter<String?> onAuthorized,
  }) async {
    final identityProvider = _identityProviderFor(provider);
    try {
      final credential = await _auth.signInWithPopup(identityProvider);
      onAuthorized(null);
      return SignInAttemptSucceeded(credential);
    } on FirebaseAuthException catch (error, stackTrace) {
      if (_cancelCodes.contains(error.code)) {
        return const SignInAttemptCancelled();
      }
      if (error.code == _popupBlocked) return _redirect(identityProvider);
      return _failed(error, stackTrace);
    } on Object catch (error, stackTrace) {
      return _failed(error, stackTrace);
    }
  }

  @override
  Future<void> signOut() async {}

  @override
  bool supports(AuthProvider provider) => true;

  @override
  Future<SignInAttempt?> completeRedirect() async {
    try {
      final result = await _auth.getRedirectResult();
      if (result.user == null) return null;
      return SignInAttemptSucceeded(
        result,
        provider: _providerOf(
          result.additionalUserInfo?.providerId ??
              result.credential?.providerId,
        ),
      );
    } on FirebaseAuthException catch (error, stackTrace) {
      final provider = _providerOf(error.credential?.providerId);
      if (_cancelCodes.contains(error.code)) {
        return SignInAttemptCancelled(provider: provider);
      }
      return _failed(error, stackTrace, provider: provider);
    } on Object catch (error, stackTrace) {
      return _failed(error, stackTrace);
    }
  }

  Future<SignInAttempt> _redirect(
    firebase.AuthProvider identityProvider,
  ) async {
    try {
      await _auth
          .signInWithRedirect(identityProvider)
          .timeout(_redirectGrace, onTimeout: () {});
      return const SignInAttemptRedirecting();
    } on Object catch (error, stackTrace) {
      return _failed(error, stackTrace);
    }
  }

  AuthProvider? _providerOf(String? providerId) => switch (providerId) {
    'google.com' => AuthProvider.google,
    'apple.com' => AuthProvider.apple,
    _ => null,
  };

  firebase.AuthProvider _identityProviderFor(AuthProvider provider) =>
      switch (provider) {
        AuthProvider.google =>
          GoogleAuthProvider()
            ..setCustomParameters({'prompt': 'select_account'}),
        AuthProvider.apple =>
          AppleAuthProvider()
            ..addScope('email')
            ..addScope('name'),
      };

  SignInError _reasonFor(Object error) => switch (error) {
    FirebaseAuthException(code: 'unauthorized-domain') =>
      SignInError.providerDisabled,
    FirebaseAuthException(
      code: 'web-storage-unsupported' ||
          'operation-not-supported-in-this-environment',
    ) =>
      SignInError.unsupported,
    _ => _errors.reasonFor(error),
  };

  SignInAttemptFailed _failed(
    Object error,
    StackTrace stackTrace, {
    AuthProvider? provider,
  }) => SignInAttemptFailed(
    error,
    stackTrace,
    reason: _reasonFor(error),
    code: _errors.codeOf(error),
    provider: provider,
  );
}

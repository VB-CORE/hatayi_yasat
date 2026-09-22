import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/foundation.dart';
import 'package:lifeclient/core/service/auth/apple_sign_in_service.dart';
import 'package:lifeclient/core/service/auth/auth_credential_provider.dart';
import 'package:lifeclient/core/service/auth/google_sign_in_service.dart';
import 'package:lifeclient/core/service/auth/sign_in_error_mapper.dart';
import 'package:lifeclient/core/service/auth/sign_in_strategy/sign_in_strategy.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/credential_result.dart';
import 'package:lifeclient/product/model/auth/sign_in_attempt.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

final class PlatformSignInStrategy implements SignInStrategy {
  PlatformSignInStrategy({
    FirebaseAuth? auth,
    AuthCredentialProvider? googleProvider,
    AuthCredentialProvider? appleProvider,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _googleProvider = googleProvider ?? GoogleSignInService(),
       _appleProvider = appleProvider ?? AppleSignInService();

  final FirebaseAuth _auth;
  final AuthCredentialProvider _googleProvider;
  final AuthCredentialProvider _appleProvider;

  static const _errors = SignInErrorMapper();

  @override
  Future<SignInAttempt> signIn(
    AuthProvider provider, {
    required ValueSetter<String?> onAuthorized,
  }) async {
    try {
      switch (await _providerFor(provider).credential()) {
        case CredentialCancelled():
          return const SignInAttemptCancelled();
        case CredentialFailed(
          :final error,
          :final stackTrace,
          :final reason,
          :final code,
        ):
          return SignInAttemptFailed(
            error,
            stackTrace,
            reason: reason,
            code: code,
          );
        case CredentialReady(:final credential, :final displayName):
          onAuthorized(displayName);
          return SignInAttemptSucceeded(
            await _auth.signInWithCredential(credential),
          );
      }
    } on Object catch (error, stackTrace) {
      return SignInAttemptFailed(
        error,
        stackTrace,
        reason: _reasonFor(error),
        code: _errors.codeOf(error),
      );
    }
  }

  @override
  Future<void> signOut() =>
      Future.wait(_providers.map((provider) => provider.signOut()));

  SignInError _reasonFor(Object error) =>
      error is SocketException ? SignInError.network : _errors.reasonFor(error);

  AuthCredentialProvider _providerFor(AuthProvider provider) =>
      switch (provider) {
        AuthProvider.google => _googleProvider,
        AuthProvider.apple => _appleProvider,
      };

  Iterable<AuthCredentialProvider> get _providers =>
      AuthProvider.values.map(_providerFor);
}

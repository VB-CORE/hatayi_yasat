import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeclient/core/security/nonce_generator.dart';
import 'package:lifeclient/core/service/auth/auth_credential_provider.dart';
import 'package:lifeclient/product/model/auth/credential_result.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AppleSignInService implements AuthCredentialProvider {
  AppleSignInService({NonceGenerator? nonceGenerator})
    : _nonceGenerator = nonceGenerator ?? const NonceGenerator();

  final NonceGenerator _nonceGenerator;

  @override
  Future<CredentialResult> credential() async {
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
      return _failed(error, stackTrace);
    } on Object catch (error, stackTrace) {
      return _failed(error, stackTrace);
    }

    final identityToken = appleCredential.identityToken;
    if (identityToken == null) {
      return _failed(
        const SignInWithAppleCredentialsException(
          message: 'Apple returned no identity token',
        ),
        StackTrace.current,
      );
    }
    return CredentialReady(
      AppleAuthProvider.credentialWithIDToken(
        identityToken,
        rawNonce,
        AppleFullPersonName(
          givenName: appleCredential.givenName,
          familyName: appleCredential.familyName,
        ),
      ),
      displayName: _displayName(appleCredential),
    );
  }

  /// Apple keeps no local session to clear; the account picker is driven by
  /// the system, not by this SDK.
  @override
  Future<void> signOut() async {}

  CredentialFailed _failed(Object error, StackTrace stackTrace) =>
      CredentialFailed(
        error,
        stackTrace,
        reason: _reasonFor(error),
        code: _codeOf(error),
      );

  SignInError _reasonFor(Object error) => switch (error) {
    SignInWithAppleNotSupportedException() => SignInError.unsupported,
    SignInWithAppleCredentialsException() => SignInError.invalidCredential,
    SignInWithAppleAuthorizationException(:final code) => switch (code) {
      AuthorizationErrorCode.invalidResponse ||
      AuthorizationErrorCode.failed => SignInError.invalidCredential,
      _ => SignInError.unknown,
    },
    TimeoutException() || SocketException() => SignInError.network,
    _ => SignInError.unknown,
  };

  String _codeOf(Object error) => switch (error) {
    SignInWithAppleAuthorizationException(:final code, :final message) =>
      '${code.name} / $message',
    SignInWithAppleException() => error.toString(),
    _ => error.runtimeType.toString(),
  };

  /// Apple hands the name back only on the very first authorization, so it is
  /// returned as data rather than read again later.
  String? _displayName(AuthorizationCredentialAppleID credential) {
    final parts = [credential.givenName, credential.familyName]
        .whereType<String>()
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty);
    return parts.isEmpty ? null : parts.join(' ');
  }
}

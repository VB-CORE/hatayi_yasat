import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeclient/core/service/auth/auth_credential_provider.dart';
import 'package:lifeclient/product/model/auth/credential_result.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

final class GoogleSignInService implements AuthCredentialProvider {
  GoogleSignInService({GoogleSignIn? client})
    : _client = client ?? GoogleSignIn.instance;

  final GoogleSignIn _client;

  bool _initialized = false;

  @override
  Future<CredentialResult> credential() async {
    try {
      if (!_initialized) {
        await _client.initialize();
        _initialized = true;
      }

      final account = await _client.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        return _failed(
          StateError('Google returned no idToken for ${account.email}'),
          StackTrace.current,
        );
      }
      return CredentialReady(GoogleAuthProvider.credential(idToken: idToken));
    } on GoogleSignInException catch (error, stackTrace) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return const CredentialCancelled();
      }
      return _failed(error, stackTrace);
    } on Object catch (error, stackTrace) {
      return _failed(error, stackTrace);
    }
  }

  @override
  Future<void> signOut() => _client.signOut();

  CredentialFailed _failed(Object error, StackTrace stackTrace) =>
      CredentialFailed(
        error,
        stackTrace,
        reason: _reasonFor(error),
        code: _codeOf(error),
      );

  SignInError _reasonFor(Object error) => switch (error) {
    GoogleSignInException(:final code) => switch (code) {
      GoogleSignInExceptionCode.interrupted => SignInError.network,
      GoogleSignInExceptionCode.uiUnavailable => SignInError.unsupported,
      GoogleSignInExceptionCode.providerConfigurationError ||
      GoogleSignInExceptionCode.clientConfigurationError =>
        SignInError.providerDisabled,
      _ => SignInError.unknown,
    },
    StateError() => SignInError.invalidCredential,
    TimeoutException() || SocketException() => SignInError.network,
    _ => SignInError.unknown,
  };

  String _codeOf(Object error) => switch (error) {
    GoogleSignInException(:final code, :final description) =>
      '${code.name} / $description',
    _ => error.runtimeType.toString(),
  };
}

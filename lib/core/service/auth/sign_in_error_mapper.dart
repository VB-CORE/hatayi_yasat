import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/services.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

final class SignInErrorMapper {
  const SignInErrorMapper();

  SignInError reasonFor(Object error) => switch (error) {
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
    TimeoutException() => SignInError.network,
    PlatformException(:final code) when code == 'network_error' =>
      SignInError.network,
    _ => SignInError.unknown,
  };

  String codeOf(Object error) => switch (error) {
    FirebaseAuthException(:final code) => code,
    PlatformException(:final code) => code,
    _ => error.runtimeType.toString(),
  };
}

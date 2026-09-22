import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_attempt.dart';

abstract interface class SignInStrategy {
  Future<SignInAttempt> signIn(
    AuthProvider provider, {
    required ValueSetter<String?> onAuthorized,
  });

  Future<void> signOut();
}

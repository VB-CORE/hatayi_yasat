import 'package:flutter/foundation.dart';
import 'package:lifeclient/core/service/auth/sign_in_strategy/sign_in_strategy.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_attempt.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

final class PlatformSignInStrategy implements SignInStrategy {
  const PlatformSignInStrategy();

  @override
  Future<SignInAttempt> signIn(
    AuthProvider provider, {
    required ValueSetter<String?> onAuthorized,
  }) async => SignInAttemptFailed(
    UnsupportedError('${provider.name} sign-in is not available on web'),
    StackTrace.current,
    reason: SignInError.unsupported,
    code: 'web-sign-in-unsupported',
  );

  @override
  Future<void> signOut() async {}
}

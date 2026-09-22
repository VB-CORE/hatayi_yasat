import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

sealed class SignInAttempt {
  const SignInAttempt();
}

final class SignInAttemptSucceeded extends SignInAttempt {
  const SignInAttemptSucceeded(this.credential);

  final UserCredential credential;
}

final class SignInAttemptCancelled extends SignInAttempt {
  const SignInAttemptCancelled();
}

final class SignInAttemptFailed extends SignInAttempt {
  const SignInAttemptFailed(
    this.error,
    this.stackTrace, {
    required this.reason,
    required this.code,
  });

  final Object error;
  final StackTrace stackTrace;
  final SignInError reason;
  final String code;
}

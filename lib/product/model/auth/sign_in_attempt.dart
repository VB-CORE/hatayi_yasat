import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

sealed class SignInAttempt {
  const SignInAttempt({this.provider});

  final AuthProvider? provider;
}

final class SignInAttemptSucceeded extends SignInAttempt {
  const SignInAttemptSucceeded(this.credential, {super.provider});

  final UserCredential credential;
}

final class SignInAttemptCancelled extends SignInAttempt {
  const SignInAttemptCancelled({super.provider});
}

final class SignInAttemptFailed extends SignInAttempt {
  const SignInAttemptFailed(
    this.error,
    this.stackTrace, {
    required this.reason,
    required this.code,
    super.provider,
  });

  final Object error;
  final StackTrace stackTrace;
  final SignInError reason;
  final String code;
}

final class SignInAttemptRedirecting extends SignInAttempt {
  const SignInAttemptRedirecting();
}

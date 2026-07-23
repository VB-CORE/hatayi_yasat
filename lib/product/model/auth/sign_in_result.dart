import 'package:lifeclient/product/model/auth/user_model.dart';

sealed class SignInResult {
  const SignInResult();
}

final class SignInSuccess extends SignInResult {
  const SignInSuccess(this.user);
  final UserModel user;
}

final class SignInCancelled extends SignInResult {
  const SignInCancelled();
}

final class SignInFailure extends SignInResult {
  const SignInFailure();
}

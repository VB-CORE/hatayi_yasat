import 'package:life_shared/life_shared.dart';

sealed class SignInResult {
  const SignInResult();
}

final class SignInSuccess extends SignInResult {
  const SignInSuccess(this.user, {this.isNewUser = false});
  final UserModel user;

  final bool isNewUser;
}

final class SignInCancelled extends SignInResult {
  const SignInCancelled();
}

final class SignInFailure extends SignInResult {
  const SignInFailure();
}

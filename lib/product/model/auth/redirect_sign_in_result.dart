import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

sealed class RedirectSignInResult {
  const RedirectSignInResult(this.provider);

  final AuthProvider? provider;
}

final class RedirectSignInSuccess extends RedirectSignInResult {
  const RedirectSignInSuccess(super.provider, {required this.isNewUser});

  final bool isNewUser;
}

final class RedirectSignInFailure extends RedirectSignInResult {
  const RedirectSignInFailure(super.provider, this.reason);

  final SignInError reason;
}

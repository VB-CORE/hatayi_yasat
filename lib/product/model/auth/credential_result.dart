import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeclient/product/model/auth/sign_in_error.dart';

sealed class CredentialResult {
  const CredentialResult();
}

final class CredentialReady extends CredentialResult {
  const CredentialReady(this.credential, {this.displayName});

  final AuthCredential credential;
  final String? displayName;
}

final class CredentialCancelled extends CredentialResult {
  const CredentialCancelled();
}

final class CredentialFailed extends CredentialResult {
  const CredentialFailed(
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

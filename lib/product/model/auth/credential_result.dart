import 'package:firebase_auth/firebase_auth.dart';

/// Outcome of asking a provider for a Firebase [AuthCredential].
///
/// Providers return this instead of throwing so the caller cannot mistake a
/// user who backed out for one whose sign-in genuinely broke.
sealed class CredentialResult {
  const CredentialResult();
}

final class CredentialReady extends CredentialResult {
  const CredentialReady(this.credential);

  final AuthCredential credential;
}

final class CredentialCancelled extends CredentialResult {
  const CredentialCancelled();
}

final class CredentialFailed extends CredentialResult {
  const CredentialFailed(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;
}

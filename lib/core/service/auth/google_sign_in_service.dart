import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeclient/product/model/auth/credential_result.dart';

final class GoogleSignInService {
  GoogleSignInService({GoogleSignIn? client})
    : _client = client ?? GoogleSignIn.instance;

  final GoogleSignIn _client;
  bool _initialized = false;

  Future<CredentialResult> credential() async {
    try {
      if (!_initialized) {
        await _client.initialize();
        _initialized = true;
      }

      final account = await _client.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        return CredentialFailed(
          StateError('Google returned no idToken for ${account.email}'),
          StackTrace.current,
        );
      }
      return CredentialReady(GoogleAuthProvider.credential(idToken: idToken));
    } on GoogleSignInException catch (error, stackTrace) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return const CredentialCancelled();
      }
      return CredentialFailed(error, stackTrace);
    } on Object catch (error, stackTrace) {
      return CredentialFailed(error, stackTrace);
    }
  }

  Future<void> signOut() => _client.signOut();
}

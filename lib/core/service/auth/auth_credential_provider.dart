import 'package:lifeclient/product/model/auth/credential_result.dart';

abstract interface class AuthCredentialProvider {
  Future<CredentialResult> credential();

  Future<void> signOut();
}

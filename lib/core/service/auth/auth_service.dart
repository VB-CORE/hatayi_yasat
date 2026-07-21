import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/sign_in_result.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';

abstract interface class AuthService {
  Stream<UserModel?> get userStream;
  UserModel? get cachedUser;
  Future<SignInResult> signIn(AuthProvider provider);
  Future<void> signOut();
}

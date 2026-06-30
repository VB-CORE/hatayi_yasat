import 'package:lifeclient/product/model/auth/app_user.dart';

abstract interface class AuthService {
  Stream<AppUser?> get userStream;
  Future<AppUser?> signInWithGoogle();
}

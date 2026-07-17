import 'package:lifeclient/product/model/auth/app_user_model.dart';

abstract interface class AuthService {
  Stream<AppUser?> get userStream;
  Future<AppUser?> signInWithGoogle();
  Future<void> signOut();
  bool get isSignedIn;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

final class FirebaseAuthService implements AuthService {
  FirebaseAuthService()
    : _auth = FirebaseAuth.instance,
      _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  @override
  Stream<AppUser?> get userStream => _auth.authStateChanges().map(
    (user) => null,
  );

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user == null) return null;
      return AppUser(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? user.email ?? '',
        photoUrl: user.photoURL,
      );
    } on Exception {
      return null;
    }
  }
}

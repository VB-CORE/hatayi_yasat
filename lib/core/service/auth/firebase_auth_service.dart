import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

final class FirebaseAuthService implements AuthService {
  FirebaseAuthService()
    : _auth = FirebaseAuth.instance,
      _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  // TODO(auth): Firestore users/{uid} koleksiyonu hazır olunca burada
  // gerçek AppUser (role dahil) dönülecek. Şu an bilinçli olarak her zaman
  // null dönüyoruz — session persistence mock akışla test ediliyor.
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
    } on Exception catch (e, stackTrace) {
      // TODO(auth): Merkezi bir logging servisi eklenince (ayrı PR) buraya bağlanacak.
      debugPrint('signInWithGoogle failed: $e\n$stackTrace');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([_googleSignIn.signOut(), _auth.signOut()]);
    } on Exception catch (e, stackTrace) {
      // TODO(auth): Merkezi bir logging servisi eklenince (ayrı PR) buraya bağlanacak.
      debugPrint('signOut failed: $e\n$stackTrace');
    }
  }
}

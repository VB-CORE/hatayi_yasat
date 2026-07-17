import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/user_doc_cache_model.dart';
import 'package:lifeclient/product/model/auth/app_user_model.dart';
import 'package:lifeclient/product/model/auth/firestore_user_doc_model.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';

final class FirebaseAuthService
    with ProjectDependencyMixin
    implements AuthService {
  FirebaseAuthService()
    : _auth = FirebaseAuth.instance,
      _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  @override
  bool get isSignedIn => _auth.currentUser != null;

  AppUser _toAppUser(User user, Map<String, dynamic>? docData) {
    return AppUser.fromJson({
      'uid': user.uid,
      'email': user.email ?? '',
      'displayName': user.displayName ?? user.email ?? '',
      'photoUrl': user.photoURL,
      'permissions': docData?['permissions'],
    });
  }

  @override
  Stream<AppUser?> get userStream => _auth.authStateChanges().asyncExpand((
    user,
  ) {
    if (user == null) return Stream<AppUser?>.value(null);

    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    return doc.snapshots().asyncMap((snapshot) async {
      await _refreshTokenIfUserDocChanged(user, snapshot);
      return _toAppUser(user, snapshot.data());
    });
  });

  // Doküman değiştiyse cache güncellenir ve token force-refresh edilir; token cache'lenmez.
  Future<void> _refreshTokenIfUserDocChanged(
    User user,
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) async {
    try {
      final data = snapshot.data();
      if (data == null) return;
      await productCache.init();
      final current = UserDocCacheModel.fromFirestoreDoc(
        FirestoreUserDocModel.fromJson(data),
      );
      if (productCache.userDocCache.get(user.uid) == current) return;
      productCache.userDocCache.add(current);
      await user.getIdTokenResult(true);
    } catch (_) {
      // Hive henüz hazır olmayabilir; login'i engellememek için yutulur.
    }
  }

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
      final result = await _auth
          .signInWithCredential(credential)
          .timeout(DurationConstant.durationNetworkTimeout);
      final user = result.user;
      if (user == null) return null;

      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);
      final doc = await docRef.get().timeout(
        DurationConstant.durationNetworkTimeout,
      );
      if (!doc.exists) {
        final newUserDoc = FirestoreUserDocModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoUrl: user.photoURL,
        );
        await docRef
            .set(newUserDoc.toJson())
            .timeout(DurationConstant.durationNetworkTimeout);
      }

      return _toAppUser(user, doc.data());
    } catch (_) {
      // Exception/Error fark etmeksizin login başarısız sayılır.
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _auth.signOut(),
    ]).timeout(DurationConstant.durationNetworkTimeout);
  }
}

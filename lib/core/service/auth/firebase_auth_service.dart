import 'dart:async';

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

  // Auth durumu değişir değişmez önceki kullanıcının doküman dinleyicisi iptal
  // edilir (switchMap davranışı) — çıkış/giriş olayları eski dinleyicinin
  // kapanmasını beklemez.
  @override
  Stream<AppUser?> get userStream {
    StreamSubscription<User?>? authSubscription;
    StreamSubscription<AppUser?>? docSubscription;
    late final StreamController<AppUser?> controller;

    controller = StreamController<AppUser?>(
      onListen: () {
        authSubscription = _auth.authStateChanges().listen((user) {
          unawaited(docSubscription?.cancel());
          docSubscription = null;
          if (user == null) {
            controller.add(null);
            return;
          }
          docSubscription = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots()
              .asyncMap((snapshot) async {
                await _refreshTokenIfUserDocChanged(user, snapshot);
                return AppUser.fromFirebaseUser(user, snapshot.data());
              })
              .listen(controller.add, onError: controller.addError);
        });
      },
      onCancel: () async {
        await docSubscription?.cancel();
        await authSubscription?.cancel();
      },
    );
    return controller.stream;
  }

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
      await user
          .getIdTokenResult(true)
          .timeout(DurationConstant.durationNetworkTimeout);
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

      final docData = await _fetchOrCreateUserDoc(user);
      return AppUser.fromFirebaseUser(user, docData);
    } catch (_) {
      // Auth açılıp Firestore adımı başarısız olursa yarım oturum kalmasın.
      signOut().ignore();
      return null;
    }
  }

  Future<Map<String, dynamic>> _fetchOrCreateUserDoc(User user) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final doc = await docRef.get().timeout(
      DurationConstant.durationNetworkTimeout,
    );
    final existingData = doc.data();
    if (existingData != null) return existingData;

    final newUserDocJson = FirestoreUserDocModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoUrl: user.photoURL,
    ).toJson();
    await docRef
        .set(newUserDocJson)
        .timeout(DurationConstant.durationNetworkTimeout);
    return newUserDocJson;
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _auth.signOut(),
    ]).timeout(DurationConstant.durationNetworkTimeout);
  }
}

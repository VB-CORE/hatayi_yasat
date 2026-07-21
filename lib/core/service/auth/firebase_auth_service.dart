import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/user_doc_cache_model.dart';
import 'package:lifeclient/product/model/auth/app_user_model.dart';

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
          docSubscription = firebaseService
              .collectionReference(CollectionPaths.users, const AppUser.empty())
              .doc(user.uid)
              .snapshots()
              .asyncMap((snapshot) async {
                final appUser = snapshot.data();
                if (appUser != null) {
                  await _refreshTokenIfUserDocChanged(user, appUser);
                }
                return appUser;
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

  Future<void> _refreshTokenIfUserDocChanged(User user, AppUser appUser) async {
    final current = UserDocCacheModel.fromAppUser(appUser);
    if (productCache.userDocCache.get(user.uid) == current) return;
    productCache.userDocCache.add(current);
    await user.getIdTokenResult(true);
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    try {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user == null) throw Exception();

      return await _fetchOrCreateUserDoc(user);
    } catch (_) {
      // Auth açılıp Firestore adımı başarısız olursa yarım oturum kalmasın.
      unawaited(signOut());
      rethrow;
    }
  }

  Future<AppUser> _fetchOrCreateUserDoc(User user) async {
    final existing = await firebaseService.getSingleData(
      model: const AppUser.empty(),
      path: CollectionPaths.users,
      id: user.uid,
    );
    if (existing != null && existing.uid.isNotEmpty) return existing;

    final newUser = AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? user.email ?? '',
      photoUrl: user.photoURL,
    );
    final isCreated = await firebaseService.insertWithID(
      ref: CollectionPaths.users,
      model: newUser,
      key: user.uid,
    );
    if (!isCreated) throw Exception();
    return newUser;
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_googleSignIn.signOut(), _auth.signOut()]);
  }
}

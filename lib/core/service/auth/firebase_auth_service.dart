import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  // TODO(auth): Geçici debug — users/{uid} doc'unu dinler; her değişimde token'ı
  // yenileyip roleType/permissions claim'lerini debugPrint eder.
  @override
  Stream<AppUser?> get userStream => _auth.authStateChanges().asyncExpand((
    user,
  ) {
    if (user == null) {
      debugPrint('[userStream] signed out');
      return Stream<AppUser?>.value(null);
    }
    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    unawaited(_ensureUserDoc(doc, user));
    return doc.snapshots().asyncMap((snapshot) async {
      final tokenResult = await user.getIdTokenResult(true);
      debugPrint('[userStream] uid=${user.uid}');
      debugPrint('[userStream] doc.permissions=${snapshot.data()?["permissions"]}');
      debugPrint(
        '[userStream] claims.permissions=${tokenResult.claims?["permissions"]}',
      );
      return AppUser(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? user.email ?? '',
        photoUrl: user.photoURL,
      );
    });
  });

  // users/{uid} yoksa oluşturur. Create rule'una uyar: roleType=2, permissions boş.
  Future<void> _ensureUserDoc(
    DocumentReference<Map<String, dynamic>> doc,
    User user,
  ) async {
    try {
      final snapshot = await doc.get();
      if (snapshot.exists) return;
      await doc.set({
        'uid': user.uid,
        'email': user.email ?? '',
        'displayName': user.displayName ?? '',
        'roleType': 2,
        'permissions': <int>[],
      });
      debugPrint('[userStream] created users/${user.uid}');
    } on Exception catch (e) {
      debugPrint('[userStream] ensureUserDoc failed: $e');
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

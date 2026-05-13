import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/model/social/user_profile_model.dart';

@immutable
final class UserProfileRepository {
  UserProfileRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('user_profiles');

  /// One-shot read of the user's profile. Returns [UserProfile.guest]
  /// if no document exists — keeps the rest of the UI agnostic of auth.
  Future<UserProfile> get(String uid) async {
    if (uid.isEmpty || uid == 'guest') return UserProfile.guest();
    final snap = await _col.doc(uid).get();
    final data = snap.data();
    if (data == null) return UserProfile.guest();
    return UserProfile.fromJson(uid, data);
  }

  Stream<UserProfile> watch(String uid) {
    if (uid.isEmpty || uid == 'guest') {
      return Stream<UserProfile>.value(UserProfile.guest());
    }
    return _col.doc(uid).snapshots().map((s) {
      final data = s.data();
      if (data == null) return UserProfile.guest();
      return UserProfile.fromJson(uid, data);
    });
  }

  /// Create-or-update; persists [updatedAt = now()] regardless of input.
  Future<UserProfile> upsert(UserProfile profile) async {
    final next = profile.copyWith(updatedAt: DateTime.now());
    await _col.doc(profile.uid).set(next.toJson(), SetOptions(merge: true));
    return next;
  }
}

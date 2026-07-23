import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/user/user_service.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';

final class FirebaseUserService implements UserService {
  FirebaseUserService({
    required FirebaseCustomService firebaseService,
    FirebaseAuth? auth,
  }) : _firebaseService = firebaseService,
       _auth = auth ?? FirebaseAuth.instance;

  final FirebaseCustomService _firebaseService;
  final FirebaseAuth _auth;

  @override
  Future<String?> uploadPhoto(File file) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    try {
      final bytes = await file.readAsBytes();
      // TODO: Burası düzenlenecek
      return FirebaseStorageService().uploadImage(
        root: .user,
        key: uid,
        fileBytes: bytes,
      );
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return null;
    }
  }

  @override
  Future<bool> update({required String displayName, String? photoUrl}) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final trimmedName = displayName.trim();
    try {
      final updated = await _firebaseService.updateFields(
        ref: CollectionPaths.users,
        documentId: user.uid,
        fields: {'displayName': trimmedName, 'photoUrl': ?photoUrl},
      );
      if (!updated) return false;

      return true;
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return false;
    }
  }

  @override
  Future<bool> addRate(String id) =>
      _updateRates(id: id, value: FieldValue.arrayUnion([id]));

  @override
  Future<bool> removeRate(String id) =>
      _updateRates(id: id, value: FieldValue.arrayRemove([id]));

  Future<bool> _updateRates({
    required String id,
    required FieldValue value,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null || id.isEmpty) return false;

    try {
      return _firebaseService.updateFields(
        ref: CollectionPaths.users,
        documentId: uid,
        fields: {'rates': value},
      );
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return false;
    }
  }
}

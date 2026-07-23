import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/user/user_service.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';

final class FirebaseUserService implements UserService {
  FirebaseUserService({
    required CustomFirestoreService firestoreService,
    required CustomStorageService storageService,
    FirebaseAuth? auth,
  }) : _firestoreService = firestoreService,
       _storageService = storageService,
       _auth = auth ?? FirebaseAuth.instance;

  final CustomFirestoreService _firestoreService;
  final CustomStorageService _storageService;
  final FirebaseAuth _auth;

  @override
  Future<String?> uploadPhoto(File file) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    try {
      final bytes = await file.readAsBytes();
      // TODO: Burası düzenlenecek
      final result = await _storageService.uploadImage(
        root: .user,
        key: uid,
        fileBytes: bytes,
      );
      return result.dataOrNull;
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return null;
    }
  }

  @override
  Future<bool> update({
    String? displayName,
    String? photoUrl,
    FieldValue? rates,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final result = await _firestoreService.updateFields(
      path: CollectionPaths.users,
      documentId: user.uid,
      fields: UserModel.updateFields(
        displayName: displayName?.trim(),
        photoUrl: photoUrl,
        rates: rates,
      ),
    );
    return result.isSuccess;
  }

  @override
  Future<bool> addRate(String id) => update(rates: FieldValue.arrayUnion([id]));

  @override
  Future<bool> removeRate(String id) =>
      update(rates: FieldValue.arrayRemove([id]));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/user/user_service.dart';
import 'package:lifeclient/product/model/auth/user/user_model.dart';

final class FirebaseUserService implements UserService {
  FirebaseUserService({
    required CustomFirestoreService firestoreService,
    FirebaseAuth? auth,
  }) : _firestoreService = firestoreService,
       _auth = auth ?? FirebaseAuth.instance;

  final CustomFirestoreService _firestoreService;
  final FirebaseAuth _auth;

  @override
  Future<bool> update({
    String? displayName,
    int? avatarType,
    FieldValue? rates,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final result = await _firestoreService.updateFields(
      path: CollectionPaths.users,
      documentId: user.uid,
      fields: UserModel.updateFields(
        displayName: displayName?.trim(),
        avatarType: avatarType,
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

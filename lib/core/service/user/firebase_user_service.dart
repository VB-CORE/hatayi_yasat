import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/user/user_service.dart';

final class FirebaseUserService implements UserService {
  FirebaseUserService({
    required CustomFirestoreService firestoreService,
    FirebaseAuth? auth,
  }) : _firestoreService = firestoreService,
       _auth = auth ?? FirebaseAuth.instance;

  final CustomFirestoreService _firestoreService;
  final FirebaseAuth _auth;

  @override
  Future<bool> update({String? displayName, int? avatarType}) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final result = await _firestoreService.updateFields(
      path: CollectionPaths.users,
      documentId: user.uid,
      fields: UserModel.updateFields(
        displayName: displayName?.trim(),
        avatarType: avatarType,
      ),
    );
    return result.isSuccess;
  }

  @override
  Future<bool> stepCounter(UserCounterFields counter, {int by = 1}) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final result = await _firestoreService.updateFields(
      path: CollectionPaths.users,
      documentId: user.uid,
      fields: UserModel.counterStep(counter, by: by),
    );
    return result.isSuccess;
  }
}

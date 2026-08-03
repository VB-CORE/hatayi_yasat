import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';

bool canDeleteContent({
  required String authorUid,
  required GroupMemberModel? currentMember,
}) {
  if (currentMember == null) return false;
  return authorUid == currentMember.uid || currentMember.isAdmin;
}

mixin SoftDeletableMixin on ProjectDependencyMixin {
  Future<bool> softDeleteContent({
    required FirestoreCollectionPath contentPath,
    required String contentId,
    required String authorUid,
    required String? currentUid,
    UserCounterFields? counterField,
    void Function(WriteBatch batch)? extraOperations,
  }) async {
    final isSelfDelete = currentUid != null && currentUid == authorUid;

    final result = await firestoreService.batchWrite((batch) {
      batch.update(
        contentPath.collection.doc(contentId),
        SoftDelete.payload(),
      );
      extraOperations?.call(batch);
      if (isSelfDelete && counterField != null) {
        batch.update(
          CollectionPaths.users.collection.doc(authorUid),
          UserModel.counterStep(counterField, by: -1),
        );
      }
    });

    return result.isSuccess;
  }
}

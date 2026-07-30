import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';

mixin GroupMembershipMixin on ProjectDependencyMixin {
  Future<FirestoreResult<GroupMemberModel?>> readMembership({
    required String groupId,
    required String uid,
  }) {
    return firestoreService.getSingleData<GroupMemberModel>(
      model: const GroupMemberModel.empty(),
      path: CommunityPaths.members(groupId),
      id: uid,
    );
  }

  Future<bool> writeJoin({
    required String groupId,
    required GroupMemberModel member,
  }) async {
    final result = await firestoreService.batchWrite(
      (batch) => batch
        ..set(
          CommunityPaths.members(groupId).collection.doc(member.uid),
          member.toJson(),
        )
        ..update(CommunityPaths.groups.collection.doc(groupId), {
          CommunityCounterFields.memberCount.name: FieldValue.increment(1),
        }),
    );
    return result.isSuccess;
  }

  Future<bool> writeLeave({
    required String groupId,
    required String uid,
  }) async {
    final result = await firestoreService.batchWrite(
      (batch) => batch
        ..update(
          CommunityPaths.members(groupId).collection.doc(uid),
          SoftDelete.payload(),
        )
        ..update(CommunityPaths.groups.collection.doc(groupId), {
          CommunityCounterFields.memberCount.name: FieldValue.increment(-1),
        }),
    );
    return result.isSuccess;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/groups/provider/groups_state.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'groups_view_model.g.dart';

@riverpod
final class GroupsViewModel extends _$GroupsViewModel
    with ProjectDependencyMixin {
  @override
  GroupsState build() => const GroupsState(groups: [], isFetching: true);

  Future<void> fetchGroups() async {
    state = state.copyWith(isFetching: true, isError: false);
    final result = await firestoreService.getList<GroupModel>(
      model: const GroupModel.empty(),
      path: CollectionPaths.groups,
    );
    final groups = (result.dataOrNull ?? const <GroupModel>[])
        .where((group) => !group.isDeleted)
        .toList();
    final withCounts = await Future.wait(
      groups.map((group) async {
        final count = await _memberCount(group.id);
        return group.copyWith(memberCount: count);
      }),
    );
    state = state.copyWith(
      groups: withCounts,
      isFetching: false,
      isError: !result.isSuccess,
    );
  }

  Future<int> _memberCount(String groupId) async {
    final result = await firestoreService.getList<GroupMemberModel>(
      model: const GroupMemberModel.empty(),
      path: CollectionPaths.groups.sub(groupId, SubCollectionPaths.members),
    );
    return (result.dataOrNull ?? const <GroupMemberModel>[])
        .where((member) => !member.isDeleted)
        .length;
  }

  Future<bool> deleteGroup(String groupId) async {
    final result = await firestoreService.updateFields(
      path: CollectionPaths.groups,
      documentId: groupId,
      fields: {
        'isDeleted': true,
        'deletedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );
    if (result.isSuccess) await fetchGroups();
    return result.isSuccess;
  }

  Future<bool> isMemberOf(String groupId) async {
    final authState = ref.read(authViewModelProvider);
    if (authState is! Authenticated) return false;
    final result = await firestoreService.getSingleData<GroupMemberModel>(
      model: const GroupMemberModel.empty(),
      path: CollectionPaths.groups.sub(groupId, SubCollectionPaths.members),
      id: authState.user.uid,
    );
    final member = result.dataOrNull;
    return member != null && !member.isDeleted;
  }

  Future<void> joinGroup(String groupId) async {
    final authState = ref.read(authViewModelProvider);
    if (authState is! Authenticated) return;
    await firestoreService.insertWithID<GroupMemberModel>(
      path: CollectionPaths.groups.sub(groupId, SubCollectionPaths.members),
      model: GroupMemberModel.fromUser(authState.user),
      key: authState.user.uid,
    );
  }
}

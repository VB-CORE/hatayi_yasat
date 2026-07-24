import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_state.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_members_view_model.g.dart';

@riverpod
final class GroupMembersViewModel extends _$GroupMembersViewModel
    with ProjectDependencyMixin {
  @override
  GroupMembersState build(String groupId) =>
      const GroupMembersState(isFetching: true);

  FirestoreCollectionPath get _path =>
      CollectionPaths.groups.sub(groupId, SubCollectionPaths.members);

  String? get _currentUid {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user.uid : null;
  }

  Future<void> fetchMembers() async {
    state = state.copyWith(isFetching: true, isError: false);
    final result = await firestoreService.getList<GroupMemberModel>(
      model: const GroupMemberModel.empty(),
      path: _path,
    );
    final members = (result.dataOrNull ?? const <GroupMemberModel>[])
        .where((member) => !member.isDeleted)
        .toList();
    state = state.copyWith(
      members: members,
      isMember: members.any((member) => member.id == _currentUid),
      isFetching: false,
      isError: !result.isSuccess,
    );
  }

  Future<bool> isCurrentUserMember() async {
    final uid = _currentUid;
    if (uid == null) return false;
    final result = await firestoreService.getSingleData<GroupMemberModel>(
      model: const GroupMemberModel.empty(),
      path: _path,
      id: uid,
    );
    final member = result.dataOrNull;
    return member != null && !member.isDeleted;
  }

  Future<void> join() async {
    final authState = ref.read(authViewModelProvider);
    if (authState is! Authenticated) return;

    state = state.copyWith(isProcessing: true);
    final result = await firestoreService.insertWithID<GroupMemberModel>(
      path: _path,
      model: GroupMemberModel.fromUser(authState.user),
      key: authState.user.uid,
    );
    state = state.copyWith(isProcessing: false);
    if (result.isSuccess) await fetchMembers();
  }

  Future<void> leave() async {
    final uid = _currentUid;
    if (uid == null) return;

    state = state.copyWith(isProcessing: true);
    final result = await firestoreService.updateFields(
      path: _path,
      documentId: uid,
      fields: {
        'isDeleted': true,
        'deletedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );
    state = state.copyWith(isProcessing: false);
    if (result.isSuccess) await fetchMembers();
  }
}

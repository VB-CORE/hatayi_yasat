import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_state.dart';
import 'package:lifeclient/features/community/provider/group_membership_mixin.dart';
import 'package:lifeclient/features/community/query/community_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_members_view_model.g.dart';

@riverpod
final class GroupMembersViewModel extends _$GroupMembersViewModel
    with ProjectDependencyMixin, CommunityQueryMixin, GroupMembershipMixin {
  @override
  GroupMembersState build(String groupId) {
    final uid = _currentUid;
    if (uid == null) return const GroupMembersState();
    unawaited(_loadMembership(uid));
    return const GroupMembersState(isFetching: true);
  }

  Query<GroupMemberModel?> get members => membersQuery(groupId);

  Query<GroupMemberModel?> get admins => adminsQuery(groupId);

  Future<bool> join() async {
    final authState = ref.read(authViewModelProvider);
    if (authState is! Authenticated || state.isProcessing) return false;

    final member = GroupMemberModel.fromUser(authState.user);
    state = state.copyWith(isProcessing: true, isError: false);

    final hasJoined = await writeJoin(groupId: groupId, member: member);
    if (!ref.mounted) return hasJoined;

    state = state.copyWith(
      currentMember: hasJoined ? member : null,
      clearCurrentMember: !hasJoined,
      isProcessing: false,
      isError: !hasJoined,
    );
    return hasJoined;
  }

  Future<bool> leave() async {
    final member = state.currentMember;
    if (member == null || state.isProcessing) return false;

    state = state.copyWith(isProcessing: true, isError: false);

    final hasLeft = await writeLeave(groupId: groupId, uid: member.uid);
    if (!ref.mounted) return hasLeft;

    state = state.copyWith(
      clearCurrentMember: hasLeft,
      isProcessing: false,
      isError: !hasLeft,
    );
    return hasLeft;
  }

  Future<void> _loadMembership(String uid) async {
    final result = await readMembership(groupId: groupId, uid: uid);
    if (!ref.mounted) return;

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        currentMember: data,
        clearCurrentMember: data == null || data.isDeleted,
        isFetching: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }

  String? get _currentUid {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user.uid : null;
  }
}

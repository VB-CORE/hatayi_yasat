import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/groups/provider/groups_state.dart';
import 'package:lifeclient/features/community/provider/group_membership_mixin.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:lifeclient/features/community/query/community_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'groups_view_model.g.dart';

@riverpod
final class GroupsViewModel extends _$GroupsViewModel
    with ProjectDependencyMixin, CommunityQueryMixin, GroupMembershipMixin {
  @override
  GroupsState build() => const GroupsState();

  void selectCategory(int? categoryValue) {
    state = state.copyWith(
      selectedCategoryValue: categoryValue,
      clearSelectedCategory: categoryValue == null,
    );
  }

  Future<bool> isMemberOf(String groupId) async {
    final uid = _currentUid;
    if (uid == null) return false;

    final result = await readMembership(groupId: groupId, uid: uid);
    final member = result.dataOrNull;
    return member != null && !member.isDeleted;
  }

  Future<bool> joinGroup(String groupId) async {
    final authState = ref.read(authViewModelProvider);
    if (authState is! Authenticated || state.isProcessing) return false;

    state = state.copyWith(isProcessing: true);
    final hasJoined = await writeJoin(
      groupId: groupId,
      member: GroupMemberModel.fromUser(authState.user),
    );
    if (ref.mounted) state = state.copyWith(isProcessing: false);
    return hasJoined;
  }

  Future<bool> deleteGroup(String groupId) async {
    state = state.copyWith(isProcessing: true);
    final result = await firestoreService.updateFields(
      path: CommunityPaths.groups,
      documentId: groupId,
      fields: SoftDelete.payload(),
    );
    if (ref.mounted) state = state.copyWith(isProcessing: false);
    return result.isSuccess;
  }

  String? get _currentUid {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user.uid : null;
  }
}

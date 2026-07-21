import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_group_member_provider.g.dart';

// TODO(community): Firestore servis PR'ında mock fallback kaldırılacak.
@riverpod
GroupMemberModel currentGroupMember(Ref ref) {
  final authState = ref.watch(authViewModelProvider);
  return authState is Authenticated
      ? GroupMemberModel.fromUser(authState.user)
      : CommunityMockData.currentMember;
}

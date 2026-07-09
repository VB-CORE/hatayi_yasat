import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_state.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_discussions_view_model.g.dart';

@riverpod
final class GroupDiscussionsViewModel extends _$GroupDiscussionsViewModel
    with ProjectDependencyMixin {
  @override
  GroupDiscussionsState build() =>
      const GroupDiscussionsState(discussions: [], isFetching: true);

  // TODO(community): Firestore group_discussions koleksiyonu hazır olunca
  // firebaseService üzerinden gerçek sorguya bağlanacak.
  Future<void> fetchDiscussions(String groupId) async {
    state = state.copyWith(isFetching: true, isError: false);
    state = state.copyWith(
      discussions: CommunityMockData.discussionsOf(groupId),
      isFetching: false,
    );
  }

  // TODO(community): Firestore'a gerçek tartışma oluşturma isteği
  // bağlanacak.
  GroupDiscussionModel addDiscussion(String title, String message) {
    final currentMember = _currentMember;
    final discussion = GroupDiscussionModel(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      author: currentMember,
      createdAt: DateTime.now(),
      entries: [
        GroupDiscussionEntryModel(
          id: 'local-${DateTime.now().microsecondsSinceEpoch}',
          author: currentMember,
          content: message,
          createdAt: DateTime.now(),
        ),
      ],
    );
    state = state.copyWith(discussions: [discussion, ...state.discussions]);
    return discussion;
  }

  // TODO(community): Gerçek grup üyeliği verisi bağlanınca mock fallback
  // kaldırılacak.
  GroupMemberModel get _currentMember {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated
        ? GroupMemberModel.fromAppUser(authState.user)
        : CommunityMockData.currentMember;
  }
}

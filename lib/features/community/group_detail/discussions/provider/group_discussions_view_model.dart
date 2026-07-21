import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_state.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_discussions_view_model.g.dart';

@riverpod
final class GroupDiscussionsViewModel extends _$GroupDiscussionsViewModel
    with ProjectDependencyMixin {
  static const _localIdPrefix = 'local-';
  static const _mockFetchDelay = Duration(milliseconds: 400);

  @override
  GroupDiscussionsState build() =>
      const GroupDiscussionsState(discussions: [], isFetching: true);

  // TODO(community): Firestore servis PR'ında mock yerine gerçek istek gelecek.
  Future<void> fetchDiscussions(String groupId) async {
    state = state.copyWith(isFetching: true, isError: false);
    await Future<void>.delayed(_mockFetchDelay);
    state = state.copyWith(
      discussions: CommunityMockData.discussionsOf(groupId),
      isFetching: false,
    );
  }

  // TODO(community): Firestore servis PR'ında tartışma sunucuya yazılacak.
  GroupDiscussionModel addDiscussion(String title, String message) {
    final currentMember = ref.read(currentGroupMemberProvider);
    final createdAt = DateTime.now();
    final localId = '$_localIdPrefix${createdAt.microsecondsSinceEpoch}';
    final discussion = GroupDiscussionModel(
      id: localId,
      title: title,
      author: currentMember,
      createdAt: createdAt,
      entries: [
        GroupDiscussionEntryModel(
          id: localId,
          author: currentMember,
          content: message,
          createdAt: createdAt,
        ),
      ],
    );
    state = state.copyWith(discussions: [discussion, ...state.discussions]);
    return discussion;
  }
}

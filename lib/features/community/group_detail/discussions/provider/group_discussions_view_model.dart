import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_state.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:lifeclient/features/community/query/community_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_discussions_view_model.g.dart';

@riverpod
final class GroupDiscussionsViewModel extends _$GroupDiscussionsViewModel
    with ProjectDependencyMixin, CommunityQueryMixin {
  @override
  GroupDiscussionsState build(String groupId) => const GroupDiscussionsState();

  Query<GroupDiscussionModel?> get discussions => discussionsQuery(groupId);

  Future<GroupDiscussionModel?> startDiscussion({
    required String title,
    required String message,
  }) async {
    final member = ref
        .read(groupMembersViewModelProvider(groupId))
        .currentMember;
    if (member == null || state.isSubmitting) return null;

    state = state.copyWith(isSubmitting: true, isError: false);

    final author = AuthorModel.fromMember(member);
    final discussionReference = CommunityPaths.discussions(
      groupId,
    ).collection.doc();
    final discussion = GroupDiscussionModel.opening(
      author: author,
      title: title,
    );
    final openingEntry = GroupDiscussionEntryModel(
      author: author,
      content: message,
    );

    final result = await firestoreService.batchWrite(
      (batch) => batch
        ..set(discussionReference, discussion.toJson())
        ..set(
          CommunityPaths.entries(
            groupId,
            discussionReference.id,
          ).collection.doc(),
          openingEntry.toJson(),
        )
        ..update(
          CollectionPaths.users.collection.doc(member.uid),
          UserModel.counterStep(UserCounterFields.discussionCount),
        ),
    );

    if (ref.mounted) {
      state = state.copyWith(isSubmitting: false, isError: !result.isSuccess);
    }
    return result.isSuccess
        ? discussion.copyWith(id: discussionReference.id)
        : null;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_state.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:lifeclient/features/community/query/community_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discussion_detail_view_model.g.dart';

@riverpod
final class DiscussionDetailViewModel extends _$DiscussionDetailViewModel
    with ProjectDependencyMixin, CommunityQueryMixin {
  @override
  DiscussionDetailState build(String groupId, String discussionId) =>
      const DiscussionDetailState();

  Query<GroupDiscussionEntryModel?> get entries =>
      entriesQuery(groupId, discussionId);

  bool canDelete(GroupDiscussionEntryModel entry) {
    final member = ref.read(groupMembersViewModelProvider(groupId)).currentMember;
    if (member == null) return false;
    return entry.author.uid == member.uid || member.isAdmin;
  }

  Future<void> deleteEntry(GroupDiscussionEntryModel entry) async {
    if (state.isProcessing) return;
    state = state.copyWith(
      status: const EntryActionProcessing(EntryAction.delete),
    );

    final currentUid =
        ref.read(groupMembersViewModelProvider(groupId)).currentMember?.uid;
    final isSelfDelete = currentUid == entry.author.uid;

    final result = await firestoreService.batchWrite(
      (batch) {
        batch
          ..update(
            CommunityPaths.entries(
              groupId,
              discussionId,
            ).collection.doc(entry.id),
            SoftDelete.payload(),
          )
          ..update(
            CommunityPaths.discussions(groupId).collection.doc(discussionId),
            {CommunityCounterFields.entryCount.name: FieldValue.increment(-1)},
          );
        if (isSelfDelete) {
          batch.update(
            CollectionPaths.users.collection.doc(entry.author.uid),
            UserModel.counterStep(UserCounterFields.commentCount, by: -1),
          );
        }
      },
    );

    if (!ref.mounted) return;
    state = state.copyWith(
      status: result.isSuccess
          ? const EntryActionSucceeded(EntryAction.delete)
          : const EntryActionFailed(EntryAction.delete),
    );
  }

  void resetStatus() => state = state.copyWith(status: const EntryActionIdle());

  Future<bool> addEntry(String content) async {
    final member = ref
        .read(groupMembersViewModelProvider(groupId))
        .currentMember;
    if (member == null || state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, isError: false);

    final entry = GroupDiscussionEntryModel(
      author: AuthorModel.fromMember(member),
      content: content,
    );

    final result = await firestoreService.batchWrite(
      (batch) => batch
        ..set(
          CommunityPaths.entries(groupId, discussionId).collection.doc(),
          entry.toJson(),
        )
        ..update(
          CommunityPaths.discussions(groupId).collection.doc(discussionId),
          {
            CommunityCounterFields.entryCount.name: FieldValue.increment(1),
          },
        )
        ..update(
          CollectionPaths.users.collection.doc(member.uid),
          UserModel.counterStep(UserCounterFields.commentCount),
        ),
    );

    if (ref.mounted) {
      state = state.copyWith(isSubmitting: false, isError: !result.isSuccess);
    }
    return result.isSuccess;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_state.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/provider/content_action_status.dart';
import 'package:lifeclient/features/community/provider/soft_deletable_mixin.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:lifeclient/features/community/query/community_queries.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discussion_detail_view_model.g.dart';

@riverpod
final class DiscussionDetailViewModel extends _$DiscussionDetailViewModel
    with ProjectDependencyMixin, CommunityQueryMixin, SoftDeletableMixin {
  @override
  DiscussionDetailState build(String groupId, String discussionId) =>
      const DiscussionDetailState();

  Query<GroupDiscussionEntryModel?> get entries =>
      entriesQuery(groupId, discussionId);

  Future<bool> deleteEntry(GroupDiscussionEntryModel entry) async {
    if (state.isProcessing) return false;
    state = state.copyWith(status: const ContentActionProcessing());

    final currentUid = ref.read(authViewModelProvider).user?.uid;
    final isSuccess = await softDeleteContent(
      contentPath: CommunityPaths.entries(groupId, discussionId),
      contentId: entry.id,
      authorUid: entry.author.uid,
      currentUid: currentUid,
      counterField: UserCounterFields.commentCount,
      extraOperations: (batch) => batch.update(
        CommunityPaths.discussions(groupId).collection.doc(discussionId),
        {CommunityCounterFields.entryCount.name: FieldValue.increment(-1)},
      ),
    );

    if (!ref.mounted) return isSuccess;
    state = state.copyWith(
      status: isSuccess
          ? const ContentActionSucceeded(
              LocaleKeys.community_groupDetail_discussions_entryDeleteSuccessMessage,
            )
          : const ContentActionFailed(
              LocaleKeys.community_groupDetail_discussions_entryDeleteFailedContent,
            ),
    );
    return isSuccess;
  }

  void resetStatus() => state = state.copyWith(status: const ContentActionIdle());

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
    if (result.isSuccess) {
      await analyticsService.logEvent(
        AnalyticsEvent.createDiscussion,
        parameters: {
          AnalyticsParameter.groupId: groupId,
          AnalyticsParameter.discussionId: discussionId,
        },
      );
    }
    return result.isSuccess;
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/provider/community_image_upload_mixin.dart';
import 'package:lifeclient/features/community/provider/content_action_status.dart';
import 'package:lifeclient/features/community/provider/soft_deletable_mixin.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:lifeclient/features/community/query/community_queries.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_wall_view_model.g.dart';

@riverpod
final class GroupWallViewModel extends _$GroupWallViewModel
    with
        ProjectDependencyMixin,
        CommunityQueryMixin,
        CommunityImageUploadMixin,
        SoftDeletableMixin {
  @override
  GroupWallState build(String groupId) => const GroupWallState();

  Query<GroupPostModel?> get posts => postsQuery(groupId);

  Future<bool> deletePost(GroupPostModel post) async {
    if (state.isProcessing) return false;
    state = state.copyWith(status: const ContentActionProcessing());

    final currentUid = ref.read(authViewModelProvider).user?.uid;
    final isSuccess = await softDeleteContent(
      contentPath: CommunityPaths.posts(groupId),
      contentId: post.id,
      authorUid: post.author.uid,
      currentUid: currentUid,
      counterField: UserCounterFields.postCount,
    );

    if (!ref.mounted) return isSuccess;
    state = state.copyWith(
      status: isSuccess
          ? const ContentActionSucceeded(
              LocaleKeys.community_groupDetail_wall_deleteSuccessMessage,
            )
          : const ContentActionFailed(
              LocaleKeys.community_groupDetail_wall_deleteFailedContent,
            ),
    );
    return isSuccess;
  }

  void resetStatus() => state = state.copyWith(status: const ContentActionIdle());

  Future<bool> addPost(String content, {File? imageFile}) async {
    final member = ref
        .read(groupMembersViewModelProvider(groupId))
        .currentMember;
    if (member == null || state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, isError: false);

    String? imageUrl;
    if (imageFile != null) {
      imageUrl = (await uploadImage(imageFile)).dataOrNull;
      if (imageUrl == null) return _failed();
    }

    final post = GroupPostModel(
      author: AuthorModel.fromMember(member),
      content: content,
      imageUrl: imageUrl,
    );
    final result = await firestoreService.batchWrite(
      (batch) => batch
        ..set(CommunityPaths.posts(groupId).collection.doc(), post.toJson())
        ..update(
          CollectionPaths.users.collection.doc(member.uid),
          UserModel.counterStep(UserCounterFields.postCount),
        ),
    );

    if (!result.isSuccess) {
      await discardImage(imageUrl);
      return _failed();
    }

    if (ref.mounted) state = state.copyWith(isSubmitting: false);
    await analyticsService.logEvent(
      AnalyticsEvent.createPost,
      parameters: {AnalyticsParameter.groupId: groupId},
    );
    return true;
  }

  bool _failed() {
    if (ref.mounted) state = state.copyWith(isSubmitting: false, isError: true);
    return false;
  }
}

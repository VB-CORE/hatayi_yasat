import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/provider/community_image_upload_mixin.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:lifeclient/features/community/query/community_queries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_wall_view_model.g.dart';

@riverpod
final class GroupWallViewModel extends _$GroupWallViewModel
    with
        ProjectDependencyMixin,
        CommunityQueryMixin,
        CommunityImageUploadMixin {
  @override
  GroupWallState build(String groupId) => const GroupWallState();

  Query<GroupPostModel?> get posts => postsQuery(groupId);

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
    final result = await firestoreService.add<GroupPostModel>(
      model: post,
      path: CommunityPaths.posts(groupId),
    );

    if (!result.isSuccess) {
      await discardImage(imageUrl);
      return _failed();
    }

    if (ref.mounted) state = state.copyWith(isSubmitting: false);
    return true;
  }

  bool _failed() {
    if (ref.mounted) state = state.copyWith(isSubmitting: false, isError: true);
    return false;
  }
}

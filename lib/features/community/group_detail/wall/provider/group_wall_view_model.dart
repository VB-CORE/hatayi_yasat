import 'dart:io';

import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_post_model.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_wall_view_model.g.dart';

@riverpod
final class GroupWallViewModel extends _$GroupWallViewModel
    with ProjectDependencyMixin {
  static const _localIdPrefix = 'local-';
  static const _mockFetchDelay = Duration(milliseconds: 400);

  @override
  GroupWallState build() => GroupWallState(
    posts: const [],
    currentMember: ref.read(currentGroupMemberProvider),
    isFetching: true,
  );

  // TODO(community): Firestore servis PR'ında mock yerine gerçek istek gelecek.
  Future<void> fetchPosts(String groupId) async {
    state = state.copyWith(isFetching: true, isError: false);
    await Future<void>.delayed(_mockFetchDelay);
    state = state.copyWith(
      posts: CommunityMockData.postsOf(groupId),
      isFetching: false,
    );
  }

  void toggleLike(String postId) {
    final isLiked = state.likedPostIds.contains(postId);
    final likedPostIds = {...state.likedPostIds};
    if (isLiked) {
      likedPostIds.remove(postId);
    } else {
      likedPostIds.add(postId);
    }

    final posts = state.posts.map((post) {
      if (post.id != postId) return post;
      return post.copyWith(
        likeCount: isLiked ? post.likeCount - 1 : post.likeCount + 1,
      );
    }).toList();
    state = state.copyWith(posts: posts, likedPostIds: likedPostIds);
  }

  // TODO(community): Firestore servis PR'ında gönderi sunucuya yazılacak.
  void addPost(String content, {File? imageFile}) {
    final post = GroupPostModel(
      id: '$_localIdPrefix${DateTime.now().microsecondsSinceEpoch}',
      author: state.currentMember,
      content: content,
      createdAt: DateTime.now(),
      imageFile: imageFile,
    );
    state = state.copyWith(posts: [post, ...state.posts]);
  }
}

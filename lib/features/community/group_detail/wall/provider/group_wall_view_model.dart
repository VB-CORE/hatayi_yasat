import 'dart:io';

import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_wall_view_model.g.dart';

@riverpod
final class GroupWallViewModel extends _$GroupWallViewModel
    with ProjectDependencyMixin {
  @override
  GroupWallState build() => GroupWallState(
    posts: const [],
    currentMember: _currentMember,
    isFetching: true,
  );

  // TODO(community): Firestore group_posts koleksiyonu hazır olunca
  // firebaseService üzerinden gerçek sorguya bağlanacak.
  Future<void> fetchPosts(String groupId) async {
    state = state.copyWith(isFetching: true, isError: false);
    state = state.copyWith(
      posts: CommunityMockData.postsOf(groupId),
      isFetching: false,
    );
  }

  void toggleLike(String postId) {
    final posts = state.posts.map((post) {
      if (post.id != postId) return post;
      final isLiked = !post.isLikedByCurrentUser;
      return post.copyWith(
        isLikedByCurrentUser: isLiked,
        likeCount: isLiked ? post.likeCount + 1 : post.likeCount - 1,
      );
    }).toList();
    state = state.copyWith(posts: posts);
  }

  // TODO(community): Firestore'a gerçek gönderi yazımı + Storage görsel
  // yüklemesi bağlanacak.
  void addPost(String content, {File? imageFile}) {
    final post = GroupPostModel(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      author: state.currentMember,
      content: content,
      createdAt: DateTime.now(),
      imageFile: imageFile,
    );
    state = state.copyWith(posts: [post, ...state.posts]);
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

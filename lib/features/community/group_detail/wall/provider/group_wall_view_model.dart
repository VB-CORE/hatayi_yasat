import 'dart:io';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:lifeclient/features/community/model/group_post_model.dart';
import 'package:lifeclient/features/community/provider/current_group_member_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'group_wall_view_model.g.dart';

@riverpod
final class GroupWallViewModel extends _$GroupWallViewModel
    with ProjectDependencyMixin {
  @override
  GroupWallState build() => GroupWallState(
    posts: const [],
    currentMember: ref.read(currentGroupMemberProvider),
    isFetching: true,
  );

  FirestoreCollectionPath _pathFor(String groupId) =>
      CollectionPaths.groups.sub(groupId, SubCollectionPaths.posts);

  Future<void> fetchPosts(String groupId) async {
    state = state.copyWith(isFetching: true, isError: false);
    final result = await firestoreService.getList<GroupPostModel>(
      model: const GroupPostModel.empty(),
      path: _pathFor(groupId),
    );
    final posts =
        (result.dataOrNull ?? const <GroupPostModel>[])
            .where((post) => !post.isDeleted)
            .toList()
          ..sort(
            (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
              a.createdAt ?? DateTime(0),
            ),
          );
    state = state.copyWith(
      posts: posts,
      isFetching: false,
      isError: !result.isSuccess,
    );
  }

  Future<bool> addPost(
    String groupId,
    String content, {
    File? imageFile,
  }) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await _uploadImage(imageFile);
      if (imageUrl == null) return false;
    }
    final post = GroupPostModel(
      author: state.currentMember,
      content: content,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );
    final result = await firestoreService.add<GroupPostModel>(
      model: post,
      path: _pathFor(groupId),
    );
    final id = result.dataOrNull;
    if (id == null) return false;
    state = state.copyWith(
      posts: [
        post.copyWith(id: id),
        ...state.posts,
      ],
    );
    return true;
  }

  // Beğeni bilgisi kullanıcıya özeldir; Firestore kuralları yalnızca soft-delete
  // güncellemesine izin verdiği için sayaç şimdilik yalnızca lokal tutulur.
  void toggleLike(String postId) {
    final posts = state.posts.map((post) {
      if (post.id != postId) return post;
      return post.copyWith(likeCount: post.likeCount + 1);
    }).toList();
    state = state.copyWith(posts: posts);
  }

  Future<String?> _uploadImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final result = await storageService.uploadImage(
        root: RootStorageName.groups,
        key: const Uuid().v4(),
        fileBytes: bytes,
      );
      return result.dataOrNull;
    } on Exception {
      return null;
    }
  }
}

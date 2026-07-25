import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
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
  GroupWallState build() {
    final user = ref.read(authViewModelProvider).user;
    return GroupWallState(
      posts: const [],
      currentMember: ref.read(currentGroupMemberProvider),
      likedPostIds: user?.likedPosts.toSet() ?? const {},
      isFetching: true,
    );
  }

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
    final post = GroupPostModel.fromAuthor(
      author: state.currentMember,
      content: content,
      imageUrl: imageUrl,
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

  Future<bool> toggleLike(String groupId, String postId) async {
    final uid = ref.read(authViewModelProvider).user?.uid;
    if (uid == null) return state.likedPostIds.contains(postId);

    final willLike = !state.likedPostIds.contains(postId);
    final previousState = state;
    state = _withToggledLike(postId, like: willLike);

    final posts = _pathFor(groupId);
    final likeRef = posts
        .sub(postId, SubCollectionPaths.likes)
        .collection
        .doc(uid);
    final postRef = posts.collection.doc(postId);
    final userRef = CollectionPaths.users.collection.doc(uid);

    final result = await batchService.commit(
      (batch) => batch
        ..set(likeRef, {
          _isDeletedField: !willLike,
          _updatedAtField: FieldValue.serverTimestamp(),
          if (!willLike) _deletedAtField: FieldValue.serverTimestamp(),
        })
        ..update(userRef, {
          _likedPostsField: willLike
              ? FieldValue.arrayUnion([postId])
              : FieldValue.arrayRemove([postId]),
          _updatedAtField: FieldValue.serverTimestamp(),
        })
        ..update(postRef, {
          _likeCountField: FieldValue.increment(willLike ? 1 : -1),
        }),
    );

    if (result case FirebaseFailure()) state = previousState;
    return state.likedPostIds.contains(postId);
  }

  GroupWallState _withToggledLike(String postId, {required bool like}) {
    final likedPostIds = {...state.likedPostIds};
    if (like) {
      likedPostIds.add(postId);
    } else {
      likedPostIds.remove(postId);
    }
    final posts = state.posts.map((post) {
      if (post.id != postId) return post;
      final next = post.likeCount + (like ? 1 : -1);
      return post.copyWith(likeCount: next < 0 ? 0 : next);
    }).toList();
    return state.copyWith(posts: posts, likedPostIds: likedPostIds);
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

  static const String _isDeletedField = 'isDeleted';
  static const String _deletedAtField = 'deletedAt';
  static const String _updatedAtField = 'updatedAt';
  static const String _likedPostsField = 'likedPosts';
  static const String _likeCountField = 'likeCount';
}

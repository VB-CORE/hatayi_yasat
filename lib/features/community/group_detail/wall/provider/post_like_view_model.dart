import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/post_like_state.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_like_view_model.g.dart';

@riverpod
final class PostLikeViewModel extends _$PostLikeViewModel
    with ProjectDependencyMixin {
  @override
  PostLikeState build(String groupId, String postId) {
    final uid = _currentUid;
    if (uid == null) return const PostLikeState();
    unawaited(_load(uid));
    return const PostLikeState(isFetching: true);
  }

  Future<bool> toggle(GroupPostModel post) async {
    final uid = _currentUid;
    if (uid == null || state.isProcessing) return state.isLiked;

    final willLike = !state.isLiked;
    state = state.copyWith(isLiked: willLike, isProcessing: true);

    final likeReference = CommunityPaths.likes(
      groupId,
      post.id,
    ).collection.doc(uid);
    final postReference = CommunityPaths.posts(groupId).collection.doc(post.id);

    final result = await firestoreService.batchWrite((batch) {
      if (willLike) {
        batch.set(likeReference, PostLikeModel(uid: uid).toJson());
      } else {
        batch.update(likeReference, SoftDelete.payload());
      }
      batch.update(postReference, {
        CommunityCounterFields.likeCount.name: FieldValue.increment(
          willLike ? 1 : -1,
        ),
      });
      batch.update(
        CollectionPaths.users.collection.doc(uid),
        UserModel.counterStep(
          UserCounterFields.likeCount,
          by: willLike ? 1 : -1,
        ),
      );
    });

    if (!ref.mounted) return result.isSuccess ? willLike : !willLike;

    state = state.copyWith(
      isLiked: result.isSuccess ? willLike : !willLike,
      isProcessing: false,
    );
    return state.isLiked;
  }

  Future<void> _load(String uid) async {
    final result = await firestoreService.getSingleData<PostLikeModel>(
      model: const PostLikeModel.empty(),
      path: CommunityPaths.likes(groupId, postId),
      id: uid,
    );
    if (!ref.mounted) return;

    final like = result.dataOrNull;
    state = state.copyWith(
      isLiked: like != null && !like.isDeleted,
      isFetching: false,
    );
  }

  String? get _currentUid {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user.uid : null;
  }
}

import 'dart:async';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_community_view_model.g.dart';

@riverpod
final class RateCommunityViewModel extends _$RateCommunityViewModel
    with ProjectDependencyMixin {
  static const int previewCommentCount = 5;

  UserModel? get _currentUser {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user : null;
  }

  FirestoreCollectionPath get _votes => CollectionPaths.approvedApplications
      .sub(placeId, SubCollectionPaths.votes);

  @override
  RateCommunityState build(String placeId) {
    _votesStream = null;
    final currentUid = _currentUser?.uid;
    if (currentUid == null) {
      return const RateCommunityState(isSignInRequired: true);
    }
    unawaited(_loadMyVote(currentUid));
    return const RateCommunityState(isLoading: true);
  }

  Stream<List<RateModel>>? _votesStream;

  Stream<List<RateModel>> votesStream() => _votesStream ??= firestoreService
      .queryWithOrderBy<RateModel>(
        path: _votes,
        model: const RateModel(),
        orderBy: const MapEntry(_createdAtField, true),
      )
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((document) => document.data())
            .whereType<RateModel>()
            .toList(),
      );

  void retry() {
    final currentUid = _currentUser?.uid;
    _votesStream = null;
    state = state.copyWith(
      retryToken: state.retryToken + 1,
      isError: false,
      isLoading: currentUid != null,
    );
    if (currentUid == null) return;
    unawaited(_loadMyVote(currentUid));
  }

  Future<void> _loadMyVote(String currentUid) async {
    final result = await firestoreService.getSingleData<RateModel>(
      model: const RateModel(),
      path: _votes,
      id: currentUid,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        vote: data,
        clearVote: data == null,
        isLoading: false,
        isError: false,
      ),
      FirebaseFailure() => state.copyWith(isLoading: false, isError: true),
    };
  }

  void selectRating(double value) => state = state.copyWith(
    draftScore: value.round(),
    status: const RateActionIdle(),
  );

  void resetStatus() => state = state.copyWith(status: const RateActionIdle());

  void expandComments() => state = state.copyWith(showAllComments: true);

  Future<void> submit({String? comment}) async {
    final user = _currentUser;
    if (user == null || state.hasVoted || state.isProcessing || state.isError) {
      return;
    }
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.create),
    );
    final now = DateTime.now();
    final vote = RateModel(
      placeId: placeId,
      voterUid: user.uid,
      score: state.draftScore,
      createdAt: now,
      comment: comment?.trim(),
      userName: user.displayName,
      photoUrl: user.photoUrl,
      updatedAt: now,
    );
    final result = await firestoreService.insertWithID<RateModel>(
      path: _votes,
      model: vote,
    );
    if (result.isSuccess) {
      state = state.copyWith(
        vote: vote,
        status: const RateActionSucceeded(RateAction.create),
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.create));
    }
  }

  Future<void> changeComment({String? newComment}) async {
    final currentVote = state.vote;
    if (currentVote == null || state.isProcessing) return;
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.update),
    );
    final updated = currentVote.copyWith(
      comment: newComment?.trim(),
      updatedAt: DateTime.now(),
    );

    final result = await firestoreService.updateFields(
      path: _votes,
      documentId: updated.voterUid,
      fields: {
        _commentField: updated.comment,
        _updatedAtField: FirebaseTimeParse.dateTimeToTimestamp(
          updated.updatedAt,
        ),
      },
    );
    if (result.isSuccess) {
      state = state.copyWith(
        status: const RateActionSucceeded(RateAction.update),
        vote: updated,
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.update));
    }
  }

  Future<void> deleteVote() async {
    final currentVote = state.vote;
    if (currentVote == null || state.isProcessing) return;
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.delete),
    );
    final result = await firestoreService.delete<RateModel>(
      path: _votes,
      model: currentVote,
    );
    if (result.isSuccess) {
      state = state.copyWith(
        clearVote: true,
        status: const RateActionSucceeded(RateAction.delete),
        draftScore: 0,
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.delete));
    }
  }

  static const String _createdAtField = 'createdAt';
  static const String _commentField = 'comment';
  static const String _updatedAtField = 'updatedAt';
}

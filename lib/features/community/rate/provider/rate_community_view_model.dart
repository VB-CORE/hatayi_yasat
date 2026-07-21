import 'dart:async';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_service_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_community_view_model.g.dart';

@riverpod
final class RateCommunityViewModel extends _$RateCommunityViewModel
    with ProjectDependencyMixin {
  AppUser? get _currentUser {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user : null;
  }

  @override
  RateCommunityState build(String placeId) {
    unawaited(_loadVotes());
    return const RateCommunityState(isLoading: true);
  }

  Future<void> _loadVotes() async {
    final service = ref.read(rateCommunityServiceProvider);
    final currentUid = _currentUser?.uid;
    final commentsRequest = service.fetchRates(placeId);
    final myVoteRequest = currentUid == null
        ? Future<RateModel?>.value()
        : service.fetchMyRate(placeId, currentUid);

    final comments = await commentsRequest;
    final myVote = await myVoteRequest;

    if (myVote != null &&
        !comments.any((vote) => vote.voterUid == myVote.voterUid)) {
      comments.add(myVote);
    }
    comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    state = state.copyWith(
      vote: myVote,
      clearVote: myVote == null,
      comments: comments,
      isLoading: false,
    );
  }

  void selectRating(double value) => state = state.copyWith(
    draftScore: value.round(),
    status: const RateActionIdle(),
  );

  void resetStatus() => state = state.copyWith(status: const RateActionIdle());

  Future<void> submit({String? comment}) async {
    final user = _currentUser;
    if (user == null || state.hasVoted || state.isProcessing) return;
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
    final success = await ref.read(rateCommunityServiceProvider).rate(vote);
    if (success) {
      state = state.copyWith(
        vote: vote,
        comments: [vote, ...state.comments],
        status: const RateActionSucceeded(RateAction.create),
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.create));
    }
  }

  Future<void> editRate({String? newComment}) async {
    final currentVote = state.vote;
    if (currentVote == null || state.isProcessing) return;
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.update),
    );
    final updated = currentVote.copyWith(
      comment: newComment?.trim(),
      updatedAt: DateTime.now(),
    );

    final success = await ref
        .read(rateCommunityServiceProvider)
        .changeComment(updated);
    if (success) {
      state = state.copyWith(
        status: const RateActionSucceeded(RateAction.update),
        vote: updated,
        comments: state.comments
            .map(
              (comment) =>
                  comment.voterUid == updated.voterUid ? updated : comment,
            )
            .toList(),
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
    final success = await ref
        .read(rateCommunityServiceProvider)
        .deleteRate(currentVote);
    if (success) {
      state = state.copyWith(
        clearVote: true,
        status: const RateActionSucceeded(RateAction.delete),
        draftScore: 0,
        comments: state.comments
            .where((c) => c.voterUid != currentVote.voterUid)
            .toList(),
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.delete));
    }
  }
}

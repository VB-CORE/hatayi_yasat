import 'dart:async';
import 'package:collection/collection.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_service_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_community_view_model.g.dart';

@riverpod
final class RateCommunityViewModel extends _$RateCommunityViewModel
    with ProjectDependencyMixin {
  static const String _currentUserId = 'mock_user';
  static const String _currentUserName = 'Veli Bacik';

  @override
  RateCommunityState build(String placeId) {
    unawaited(_loadVotes());
    return const RateCommunityState(isLoading: true);
  }

  Future<void> _loadVotes() async {
    final comments = await ref
        .read(rateCommunityServiceProvider)
        .fetchRates(placeId);
    comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final myVote = comments.firstWhereOrNull(
      (vote) => vote.userId == _currentUserId,
    );
    state = state.copyWith(
      vote: myVote,
      clearVote: myVote == null,
      comments: comments,
      isLoading: false,
    );
  }

  void selectRating(double value) =>
      state = state.copyWith(draftRate: value, status: const RateActionIdle());

  void resetStatus() => state = state.copyWith(status: const RateActionIdle());

  Future<void> submit({String? comment}) async {
    if (state.hasVoted || state.isProcessing) return;
    state = state.copyWith(
      status: const RateActionProcessing(RateAction.create),
    );
    final vote = RateModel(
      placeId: placeId,
      userId: _currentUserId,
      rate: state.draftRate,
      createdAt: DateTime.now(),
      comment: comment?.trim(),
      userName: _currentUserName,
      updatedAt: DateTime.now(),
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
              (comment) => comment.userId == updated.userId ? updated : comment,
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
        draftRate: 0,
        comments: state.comments
            .where((c) => c.userId != currentVote.userId)
            .toList(),
      );
    } else {
      state = state.copyWith(status: const RateActionFailed(RateAction.delete));
    }
  }
}

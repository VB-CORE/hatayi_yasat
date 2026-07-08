import 'dart:async';
import 'package:collection/collection.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_service_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_community_provider.g.dart';

@riverpod
final class RateCommunityProvider extends _$RateCommunityProvider
    with ProjectDependencyMixin {
  static const String _currentUserId = 'mock_user_4';
  static const String _currentUserName = 'Veli Bacik';

  @override
  RateCommunityState build(String esnafId) {
    unawaited(_loadVotes());
    return const RateCommunityState(isLoading: true);
  }

  Future<void> _loadVotes() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    try {
      final comments = await ref
          .read(rateCommunityServiceProvider)
          .fetchRates(esnafId);
      comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final myVote = comments.firstWhereOrNull(
        (vote) => vote.userId == _currentUserId,
      );
      state = state.copyWith(
        vote: myVote,
        comments: comments,
        isLoading: false,
      );
    } on Exception {
      state = state.copyWith(
        isLoading: false,
        isError: true,
      );
    }
  }

  void selectRating(double value) =>
      state = state.copyWith(draftRate: value, status: const ActionIdle());

  void resetStatus() => state = state.copyWith(status: const ActionIdle());

  Future<void> submit({
    String? comment,
  }) async {
    if (state.isReadOnly || state.isProcessing) return;
    state = state.copyWith(status: const ActionProcessing(RateAction.create));
    await Future<void>.delayed(const Duration(seconds: 2));
    final vote = RateModel(
      esnafId: esnafId,
      userId: _currentUserId,
      rate: state.draftRate,
      createdAt: DateTime.now(),
      counted: false,
      comment: comment,
      userName: _currentUserName,
      photoUrl: '',
    );
    final success = await ref.read(rateCommunityServiceProvider).rate(vote);
    if (success) {
      state = state.copyWith(
        vote: vote,
        comments: [vote, ...state.comments],
        status: const ActionSucceeded(RateAction.create),
      );
    } else {
      state = state.copyWith(status: const ActionFailed(RateAction.create));
    }
  }

  Future<void> editComment(String? newComment) async {
    final currentVote = state.vote;
    if (currentVote == null || state.isProcessing) return;
    state = state.copyWith(status: const ActionProcessing(RateAction.update));
    await Future<void>.delayed(const Duration(seconds: 2));
    final updated = currentVote.copyWith(comment: newComment);
    final success = await ref
        .read(rateCommunityServiceProvider)
        .changeComment(updated);
    if (success) {
      state = state.copyWith(
        status: const ActionSucceeded(RateAction.update),
        vote: updated,
        comments: [
          for (final comment in state.comments)
            if (comment.userId == updated.userId) updated else comment,
        ],
      );
    } else {
      state = state.copyWith(status: const ActionFailed(RateAction.update));
    }
  }

  Future<void> deleteVote() async {
    final currentVote = state.vote;
    if (currentVote == null || state.isProcessing) return;
    state = state.copyWith(status: const ActionProcessing(RateAction.delete));
    await Future<void>.delayed(const Duration(seconds: 2));
    final success = await ref
        .read(rateCommunityServiceProvider)
        .deleteRate(currentVote);
    if (success) {
      state = state.copyWith(
        clearVote: true,
        status: const ActionSucceeded(RateAction.delete),
        draftRate: 0,
        comments: state.comments
            .where((c) => c.userId != currentVote.userId)
            .toList(),
      );
    } else {
      state = state.copyWith(status: const ActionFailed(RateAction.delete));
    }
  }
}

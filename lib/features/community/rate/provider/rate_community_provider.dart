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

  @override
  RateCommunityState build(String esnafId) {
    unawaited(_loadVotes());
    return const RateCommunityState(isLoading: true);
  }

  Future<void> _loadVotes() async {
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
      state = state.copyWith(isLoading: false, isError: true);
    }
  }

  void selectRating(double value) => state = state.copyWith(draftRate: value);

  Future<void> submit({String? comment}) async {
    if (state.isReadOnly) return;
    state = state.copyWith(isSubmitting: true, isActionError: false);
    final vote = RateModel(
      esnafId: esnafId,
      userId: _currentUserId,
      rate: state.draftRate,
      createdAt: DateTime.now(),
      counted: false,
      comment: comment,
    );
    try {
      await ref.read(rateCommunityServiceProvider).rate(vote);
      state = state.copyWith(
        vote: vote,
        comments: [vote, ...state.comments],
        isSubmitting: false,
      );
    } on Exception {
      state = state.copyWith(isSubmitting: false, isActionError: true);
    }
  }

  Future<void> editComment(String? newComment) async {
    final currentVote = state.vote;
    if (currentVote == null) return;
    final updated = currentVote.copyWith(comment: newComment);
    try {
      await ref.read(rateCommunityServiceProvider).changeComment(updated);
      state = state.copyWith(
        vote: updated,
        comments: [
          for (final comment in state.comments)
            if (comment.userId == updated.userId) updated else comment,
        ],
      );
    } on Exception {
      state = state.copyWith(isActionError: true);
    }
  }

  Future<void> deleteVote() async {
    final currentVote = state.vote;
    if (currentVote == null) return;
    try {
      await ref.read(rateCommunityServiceProvider).deleteRate(currentVote);
      state = state.copyWith(
        clearVote: true,
        draftRate: 0,
        comments: state.comments
            .where((c) => c.userId != currentVote.userId)
            .toList(),
      );
    } on Exception {
      state = state.copyWith(isActionError: true);
    }
  }
}

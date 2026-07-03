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
  static const String _currentUserId = 'mock_user_3';

  @override
  RateCommunityState build(String esnafId) {
    unawaited(_loadVotes());
    return const RateCommunityState(isLoading: true);
  }

  Future<void> _loadVotes() async {
    final votes = await ref
        .read(rateCommunityServiceProvider)
        .fetchRates(esnafId);
    final myVote = votes.firstWhereOrNull(
      (vote) => vote.userId == _currentUserId,
    );
    state = state.copyWith(vote: myVote, isLoading: false);
  }

  void selectRating(double value) => state = state.copyWith(draftRate: value);

  Future<void> submit({String? comment}) async {
    if (state.isReadOnly) return;
    state = state.copyWith(isSubmitting: true);
    final vote = RateModel(
      esnafId: esnafId,
      userId: _currentUserId,
      rate: state.draftRate,
      createdAt: DateTime.now(),
      counted: false,
      comment: comment,
    );
    await ref.read(rateCommunityServiceProvider).rate(vote);
    state = state.copyWith(vote: vote, isSubmitting: false);
  }

  Future<void> editComment(String? newComment) async {
    final currentVote = state.vote;
    if (currentVote == null) return;
    final updated = currentVote.copyWith(comment: newComment);
    await ref.read(rateCommunityServiceProvider).changeComment(updated);
    state = state.copyWith(vote: updated);
  }

  Future<void> deleteVote() async {
    final currentVote = state.vote;
    if (currentVote == null) return;
    await ref.read(rateCommunityServiceProvider).deleteRate(currentVote);
    state = const RateCommunityState();
  }
}

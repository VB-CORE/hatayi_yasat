import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_community_provider.g.dart';

@riverpod
final class RateCommunityProvider extends _$RateCommunityProvider
    with ProjectDependencyMixin {
  static final Map<String, Map<String, RateModel>> _mockVotesByPlace = {
    'place_1': {
      'mock_user_1': RateModel(
        rate: 4,
        counted: true,
        createdAt: DateTime(2026, 6, 28),
        comment: 'Çok temiz ve ilgili bir esnaf, tavsiye ederim.',
      ),
    },
    'place_2': {
      'mock_user_2': RateModel(
        rate: 5,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Fiyatlar uygun, hizmet güzeldi.',
      ),
    },
  };

  // Şimdilik tek yerde sabit.
  static const String _currentUserId = 'mock_user_3';
  @override
  RateCommunityState build(String esnafId) {
    final placeVotes =
        _mockVotesByPlace[esnafId] ?? const <String, RateModel>{};
    return RateCommunityState(vote: placeVotes[_currentUserId]);
  }

  void submit({String? comment}) {
    if (state.isReadOnly) return;
    state = state.copyWith(isSubmitting: true);
    state = state.copyWith(
      vote: RateModel(
        rate: state.draftRate,
        createdAt: DateTime.now(),
        counted: false,
        comment: comment,
      ),
    );
  }

  void selectRating(double value) => state = state.copyWith(draftRate: value);
}

import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/service/rate_community_service.dart';

final class RateCommunityMockService implements RateCommunityService {
  static final Map<String, Map<String, RateModel>> _votesByEsnaf = {
    'place_1': {
      'mock_user_1': RateModel(
        esnafId: 'place_1',
        userId: 'mock_user_1',
        rate: 4,
        counted: true,
        createdAt: DateTime(2026, 6, 28),
        comment: 'Çok temiz ve ilgili bir esnaf, tavsiye ederim.',
      ),
    },
    'place_2': {
      'mock_user_2': RateModel(
        esnafId: 'place_2',
        userId: 'mock_user_2',
        rate: 5,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Fiyatlar uygun, hizmet güzeldi.',
      ),
    },
  };

  @override
  Future<List<RateModel>> fetchRates(String esnafId) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final votes = _votesByEsnaf[esnafId] ?? const <String, RateModel>{};
    return votes.values.toList();
  }

  @override
  Future<void> rate(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final votes = _votesByEsnaf.putIfAbsent(rate.esnafId, () => {});
    votes[rate.userId] = rate;
  }

  @override
  Future<void> changeComment(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final existing = _votesByEsnaf[rate.esnafId]?[rate.userId];
    if (existing == null) return;
    _votesByEsnaf[rate.esnafId]![rate.userId] = existing.copyWith(
      comment: rate.comment,
    );
  }

  @override
  Future<void> deleteRate(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _votesByEsnaf[rate.esnafId]?.remove(rate.userId);
  }
}

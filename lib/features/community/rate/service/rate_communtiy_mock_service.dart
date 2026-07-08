import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/service/rate_community_service.dart';

final class RateCommunityMockService implements RateCommunityService {
  static final Map<String, Map<String, RateModel>> votesByEsnaf = {
    'place_1': {
      'mock_user_1': RateModel(
        esnafId: 'place_1',
        userId: 'mock_user_1',
        rate: 4,
        counted: true,
        createdAt: DateTime(2026, 6, 28),
        comment: 'Çok temiz ve ilgili bir esnaf, tavsiye ederim.',
        userName: 'Mehmet Kaya',
        photoUrl: '',
      ),
      'mock_user_2': RateModel(
        esnafId: 'place_1',
        userId: 'mock_user_2',
        rate: 2,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Fiyatlar biraz yüksek, ortalama bir deneyimdi.',
        userName: 'Zeynep Demir',
        photoUrl: '',
      ),
      'mock_user_3': RateModel(
        esnafId: 'place_1',
        userId: 'mock_user_3',
        rate: 1,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment:
            'Maalesef beklentimin çok altında bir deneyim yaşadım. Personel '
            'ilgisizdi, siparişim geç geldi ve ürün kalitesi hiç tatmin edici '
            'değildi. Bu fiyata çok daha iyi bir hizmet bekliyordum, bir daha '
            'tercih etmeyi düşünmüyorum.',
        userName: 'Ayşe yılmaz',
        photoUrl: '',
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
        userName: 'Zeynep Demir',
        photoUrl: '',
      ),
    },
  };

  @override
  Future<List<RateModel>> fetchRates(String esnafId) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final votes = votesByEsnaf[esnafId] ?? const <String, RateModel>{};
    return votes.values.toList();
  }

  @override
  Future<bool> rate(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final votes = votesByEsnaf.putIfAbsent(rate.esnafId, () => {});
    votes[rate.userId] = rate;
    return true;
  }

  @override
  Future<bool> changeComment(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final existing = votesByEsnaf[rate.esnafId]?[rate.userId];
    if (existing == null) return false;
    votesByEsnaf[rate.esnafId]![rate.userId] = existing.copyWith(
      comment: rate.comment,
    );
    return true;
  }

  @override
  Future<bool> deleteRate(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    votesByEsnaf[rate.esnafId]?.remove(rate.userId);
    return true;
  }
}

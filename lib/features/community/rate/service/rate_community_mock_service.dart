import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/service/rate_community_service.dart';

final class RateCommunityMockService implements RateCommunityService {
  static final Map<String, Map<String, RateModel>> votesByPlace = {
    'place_1': {
      'mock_user_1': RateModel(
        placeId: 'place_1',
        userId: 'mock_user_1',
        rate: 4,
        counted: true,
        createdAt: DateTime(2026, 6, 28),
        comment: 'Çok temiz ve ilgili bir esnaf, tavsiye ederim.',
        userName: 'Mehmet Kaya',
      ),
      'mock_user_2': RateModel(
        placeId: 'place_1',
        userId: 'mock_user_2',
        rate: 2,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Fiyatlar biraz yüksek, ortalama bir deneyimdi.',
        userName: 'Zeynep Demir',
      ),
      'mock_user_3': RateModel(
        placeId: 'place_1',
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
      ),
      'mock_user_4': RateModel(
        placeId: 'place_1',
        userId: 'mock_user_4',
        rate: 3,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Ortalama bir deneyim, fiyatlar biraz yüksek.',
        userName: 'Ahmet Yılmaz',
      ),
      'mock_user_5': RateModel(
        placeId: 'place_1',
        userId: 'mock_user_5',
        rate: 5,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Harika bir deneyim, tavsiye ederim.',
        userName: 'Mehmet Kaya',
      ),
      'mock_user_6': RateModel(
        placeId: 'place_1',
        userId: 'mock_user_6',
        rate: 4,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Ortalama bir deneyim, fiyatlar biraz yüksek.',
        userName: 'Ahmet Yılmaz',
      ),
      'mock_user_7': RateModel(
        placeId: 'place_1',
        userId: 'mock_user_7',
        rate: 4,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Ortalama bir deneyim, fiyatlar biraz yüksek.',
        userName: 'Ahmet Yılmaz',
      ),
    },
    'place_2': {
      'mock_user_2': RateModel(
        placeId: 'place_2',
        userId: 'mock_user_2',
        rate: 5,
        counted: true,
        createdAt: DateTime(2026, 6, 29),
        comment: 'Fiyatlar uygun, hizmet güzeldi.',
        userName: 'Zeynep Demir',
      ),
    },
  };

  @override
  Future<List<RateModel>> fetchRates(String placeId) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final votes =
        votesByPlace[placeId] ??
        votesByPlace['place_1'] ??
        const <String, RateModel>{};
    return votes.values.map((vote) => vote.copyWith(placeId: placeId)).toList();
  }

  @override
  Future<bool> rate(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final votes = votesByPlace.putIfAbsent(rate.placeId, () => {});
    votes[rate.userId] = rate;
    return true;
  }

  @override
  Future<bool> changeComment(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final existing = votesByPlace[rate.placeId]?[rate.userId];
    if (existing == null) return false;
    votesByPlace[rate.placeId]![rate.userId] = rate;
    return true;
  }

  @override
  Future<bool> deleteRate(RateModel rate) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    votesByPlace[rate.placeId]?.remove(rate.userId);
    return true;
  }
}

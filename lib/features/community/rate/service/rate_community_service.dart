import 'package:lifeclient/features/community/rate/model/rate_model.dart';

abstract interface class RateCommunityService {
  Future<List<RateModel>> fetchRates(String placeId);

  /// Kullanıcının kendi oyunu doküman id'sinden çeker. [fetchRates] sayfalı
  /// olduğu için oy listenin dışında kalabilir; "oy verdim mi" sorusu buradan
  /// yanıtlanmalı, aksi halde mevcut oy üzerine yazılır.
  Future<RateModel?> fetchMyRate(String placeId, String voterUid);
  Future<bool> rate(RateModel rate);
  Future<bool> changeComment(RateModel rate);
  Future<bool> deleteRate(RateModel rate);
}

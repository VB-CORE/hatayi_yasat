import 'package:lifeclient/features/community/rate/model/rate_model.dart';

abstract interface class RateCommunityService {
  Future<List<RateModel>> fetchRates(String esnafId);
  Future<void> rate(RateModel rate);
  Future<void> changeComment(RateModel rate);
  Future<void> deleteRate(RateModel rate);
}

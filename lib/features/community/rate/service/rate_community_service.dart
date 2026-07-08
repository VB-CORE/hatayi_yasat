import 'package:lifeclient/features/community/rate/model/rate_model.dart';

abstract interface class RateCommunityService {
  Future<List<RateModel>> fetchRates(String esnafId);
  Future<bool> rate(RateModel rate);
  Future<bool> changeComment(RateModel rate);
  Future<bool> deleteRate(RateModel rate);
}

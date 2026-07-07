import 'package:lifeclient/features/community/rate/model/mock_community_model.dart';
import 'package:lifeclient/features/community/rate/service/mock_community_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_community_provider.g.dart';

@riverpod
MockCommunityModel mockCommunity(Ref ref, String esnafId) {
  return MockCommunityService().fetch(esnafId);
}

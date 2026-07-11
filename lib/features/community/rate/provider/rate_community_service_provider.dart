import 'package:lifeclient/features/community/rate/service/rate_community_mock_service.dart';
import 'package:lifeclient/features/community/rate/service/rate_community_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_community_service_provider.g.dart';

@riverpod
RateCommunityService rateCommunityService(Ref ref) =>
    RateCommunityMockService();

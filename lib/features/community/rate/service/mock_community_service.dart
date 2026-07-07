import 'package:lifeclient/features/community/rate/model/mock_community_model.dart';

final class MockCommunityService {
  static const Map<String, MockCommunityModel> _settings = {
    'place_1': MockCommunityModel(esnafId: 'place_1', isComment: true),
    'place_2': MockCommunityModel(esnafId: 'place_2', isComment: false),
  };

  MockCommunityModel fetch(String esnafId) =>
      _settings[esnafId] ??
      MockCommunityModel(esnafId: esnafId, isComment: true);
}

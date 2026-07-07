import 'package:lifeclient/features/community/rate/model/mock_user_model.dart';
import 'package:lifeclient/features/community/rate/service/mock_user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_user_provider.g.dart';

@riverpod
MockUserModel mockUser(Ref ref, String userId) {
  return MockUserService().fetch(userId);
}

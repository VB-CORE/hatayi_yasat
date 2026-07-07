import 'package:lifeclient/features/community/rate/model/mock_user_model.dart';

final class MockUserService {
  static const Map<String, MockUserModel> _users = {
    'mock_user_1': MockUserModel(id: 'mock_user_1', name: 'Ayşe Yılmaz'),
    'mock_user_2': MockUserModel(id: 'mock_user_2', name: 'Mehmet Kaya'),
    'mock_user_3': MockUserModel(id: 'mock_user_3', name: 'Zeynep Demir'),
    'mock_user_4': MockUserModel(
      id: 'mock_user_4',
      name: 'Veli Bacik',
    ),
  };

  MockUserModel fetch(String userId) =>
      _users[userId] ?? MockUserModel(id: userId, name: userId);
}

import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

final class MockAuthService implements AuthService {
  static const _mockUser = AppUser(
    uid: 'mock-uid-123',
    email: 'mock@hatay.com',
    displayName: 'Mock Kullanıcı',
  );

  @override
  Stream<AppUser?> get userStream => Stream.value(_mockUser);

  @override
  Future<AppUser?> signInWithGoogle() async => _mockUser;
}

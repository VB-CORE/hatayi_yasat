import 'package:lifeclient/product/package/permission/notification_permission.dart';

final class PlatformNotificationPermission implements NotificationPermission {
  const PlatformNotificationPermission();

  @override
  bool get isSupported => false;

  @override
  Future<bool> isGranted() async => false;
}

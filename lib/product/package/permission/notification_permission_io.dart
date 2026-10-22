import 'package:lifeclient/product/package/permission/notification_permission.dart';
import 'package:permission_handler/permission_handler.dart';

final class PlatformNotificationPermission implements NotificationPermission {
  const PlatformNotificationPermission();

  @override
  bool get isSupported => true;

  @override
  Future<bool> isGranted() async {
    final status = await Permission.notification.status;
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }
}

import 'package:lifeclient/product/package/permission/notification_permission_io.dart'
    if (dart.library.js_interop) 'package:lifeclient/product/package/permission/notification_permission_web.dart';

final class NotificationPermissionUtility {
  const NotificationPermissionUtility._();

  static bool get isSupported =>
      const PlatformNotificationPermission().isSupported;

  static Future<bool> isGranted() =>
      const PlatformNotificationPermission().isGranted();
}

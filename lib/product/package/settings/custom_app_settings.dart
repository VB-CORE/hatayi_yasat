import 'package:lifeclient/product/package/settings/app_settings_opener_io.dart'
    if (dart.library.js_interop) 'package:lifeclient/product/package/settings/app_settings_opener_web.dart';

enum CustomAppSettingsType { libraryPermission, notification }

final class CustomAppSettings {
  const CustomAppSettings._();

  static bool get isSupported => const PlatformAppSettingsOpener().isSupported;

  static Future<void> open({required CustomAppSettingsType type}) =>
      const PlatformAppSettingsOpener().open(type);
}

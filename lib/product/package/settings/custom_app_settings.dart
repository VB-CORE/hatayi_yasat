import 'package:app_settings/app_settings.dart';

enum CustomAppSettingsType { libraryPermission, notification }

final class CustomAppSettings {
  const CustomAppSettings._();
  static Future<void> open({required CustomAppSettingsType type}) async {
    switch (type) {
      case CustomAppSettingsType.libraryPermission:
        await AppSettings.openAppSettings();
      case CustomAppSettingsType.notification:
        await AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }
}

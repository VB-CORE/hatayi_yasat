// ignore_for_file: constant_identifier_names

import 'package:app_settings/app_settings.dart';

enum CustomAppSettingsType { library_permission, notification }

final class CustomAppSettings {
  const CustomAppSettings._();
  static void open({required CustomAppSettingsType type}) {
    switch (type) {
      case CustomAppSettingsType.library_permission:
        AppSettings.openAppSettings();
        return;
      case CustomAppSettingsType.notification:
        AppSettings.openAppSettings(type: AppSettingsType.notification);
        return;
    }
  }
}

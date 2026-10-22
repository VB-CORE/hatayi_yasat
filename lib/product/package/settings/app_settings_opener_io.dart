import 'package:app_settings/app_settings.dart';
import 'package:lifeclient/product/package/settings/app_settings_opener.dart';
import 'package:lifeclient/product/package/settings/custom_app_settings.dart';

final class PlatformAppSettingsOpener implements AppSettingsOpener {
  const PlatformAppSettingsOpener();

  @override
  bool get isSupported => true;

  @override
  Future<void> open(CustomAppSettingsType type) async {
    switch (type) {
      case CustomAppSettingsType.libraryPermission:
        await AppSettings.openAppSettings();
      case CustomAppSettingsType.notification:
        await AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }
}

import 'package:lifeclient/product/package/settings/app_settings_opener.dart';
import 'package:lifeclient/product/package/settings/custom_app_settings.dart';

final class PlatformAppSettingsOpener implements AppSettingsOpener {
  const PlatformAppSettingsOpener();

  @override
  bool get isSupported => false;

  @override
  Future<void> open(CustomAppSettingsType type) async {}
}

import 'package:lifeclient/product/package/settings/custom_app_settings.dart';

abstract interface class AppSettingsOpener {
  bool get isSupported;

  Future<void> open(CustomAppSettingsType type);
}

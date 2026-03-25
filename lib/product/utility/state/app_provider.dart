import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/state/items/app_provider_state.dart';
import 'package:lifeclient/product/utility/state/mixin/app_provider_mixin.dart';

final class AppProvider extends Notifier<AppProviderState>
    with AppProviderOperationMixin {
  AppProvider();

  Future<void> init() async => {
    await _checkDeviceId(),
  };

  ThemeMode get currentThemeMode => state.theme;

  Future<void> _checkDeviceId() async {
    try {
      final deviceID = kIsWeb
          ? kWeb
          : await DeviceUtility.instance.getUniqueDeviceId();
      state = state.copyWith(deviceID: deviceID);
    } on Object {
      state = state.copyWith(deviceID: kWeb);
    }
  }

  /// change app theme for light and dark mode
  Future<void> changeAppTheme({required ThemeMode theme}) async {
    if (state.theme == theme) return;
    state = state.copyWith(theme: theme);
    await SharedCache.instance.setTheme(theme);
  }

  @override
  AppProviderState build() {
    return AppProviderState(
      theme: SharedCache.instance.theme,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/state/items/app_provider_state.dart';
import 'package:vbaseproject/product/utility/state/mixin/app_provider_mixin.dart';

final class AppProvider extends StateNotifier<AppProviderState>
    with AppProviderOperationMixin {
  AppProvider() : super(const AppProviderState());

  Future<void> init() async => {
        await _checkDeviceId(),
      };

  ThemeMode get currentThemeMode => state.theme;

  Future<void> _checkDeviceId() async {
    try {
      final deviceID =
          kIsWeb ? kWeb : await DeviceUtility.instance.getUniqueDeviceId();
      state = state.copyWith(deviceID: deviceID);
    } catch (e) {
      state = state.copyWith(deviceID: kWeb);
    }
  }

  /// change app theme for light and dark mode
  void changeAppTheme({required ThemeMode theme}) {
    if (state.theme == theme) return;
    state = state.copyWith(theme: theme);
  }
}

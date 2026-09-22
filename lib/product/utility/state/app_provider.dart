import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/utility/device/device_id_reader_io.dart'
    if (dart.library.js_interop) 'package:lifeclient/product/utility/device/device_id_reader_web.dart';
import 'package:lifeclient/product/utility/generator/uuid_generator.dart';
import 'package:lifeclient/product/utility/state/items/app_provider_state.dart';
import 'package:lifeclient/product/utility/state/mixin/app_provider_mixin.dart';

final class AppProvider extends Notifier<AppProviderState>
    with AppProviderOperationMixin {
  AppProvider();

  ThemeMode get currentThemeMode => state.theme;

  Future<void> _checkDeviceId() async {
    final deviceID = await _readDeviceId();
    state = state.copyWith(deviceID: deviceID);
  }

  Future<String> _readDeviceId() async {
    try {
      final platformId = await const PlatformDeviceIdReader().read();
      if (platformId != null && platformId.isNotEmpty) return platformId;
    } on Object catch (error, stackTrace) {
      ProjectDependencyItems.analyticsService.recordError(
        error,
        stackTrace,
        reason: 'device_id.platform_read',
      );
    }
    return UuidGenerator.generate();
  }

  /// change app theme for light and dark mode
  Future<void> changeAppTheme({required ThemeMode theme}) async {
    if (state.theme == theme) return;
    state = state.copyWith(theme: theme);
    await SharedCache.instance.setTheme(theme);
    ProjectDependencyItems.analyticsService.setUserProperty(
      AnalyticsUserProperty.appTheme,
      theme.name,
    );
  }

  @override
  AppProviderState build() {
    unawaited(_checkDeviceId());
    return AppProviderState(
      theme: SharedCache.instance.theme,
    );
  }
}

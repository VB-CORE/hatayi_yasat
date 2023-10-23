import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';
import 'package:vbaseproject/product/feature/cache/shared_operation/base_shared_operation.dart';

/// Todo: It's need to generic
final class SharedCache {
  SharedCache._internal();
  static final SharedCache instance = SharedCache._internal();

  late final BaseSharedOperation _sharedOperation;

  Future<void> init() async {
    _sharedOperation = SharedOperation();
    await _sharedOperation.init();
  }

  Future<void> clear() async {
    await _sharedOperation.clear();
  }

  DateTime? getLastNotificationSeenTime() {
    final lastNotificationSeenTime =
        _sharedOperation.getValue<String>(SharedKeys.lastNotificationSeenTime);
    if (lastNotificationSeenTime.ext.isNullOrEmpty) return null;
    return DateTime.tryParse(lastNotificationSeenTime!);
  }

  DateTime? getApplyScholarshipTime() {
    final time = _sharedOperation.getValue<String>(SharedKeys.applyScholarship);
    if (time == null) return null;
    return DateTime.parse(time);
  }

  Future<void> setFirstAppOpen() async {
    await _sharedOperation.setValue(SharedKeys.firstAppOpen, false);
  }

  bool get isFirstAppOpen =>
      _sharedOperation.getValue<bool>(SharedKeys.firstAppOpen) ?? true;

  bool get isRepublicDayShow =>
      _sharedOperation.getValue<bool>(SharedKeys.republicDayFirstTimeSeen) ??
      false;

  ThemeMode get theme =>
      ThemeMode.values[_sharedOperation.getValue<int>(SharedKeys.theme) ?? 0];

  /// Setters
  ///
  Future<void> setTheme(ThemeMode mode) async {
    await _sharedOperation.setValue<int>(SharedKeys.theme, mode.index);
  }

  Future<void> setRepublicDay() async {
    await _sharedOperation.setValue<bool>(
        SharedKeys.republicDayFirstTimeSeen, true);
  }

  Future<void> saveApplyScholarshipTime() async {
    await _sharedOperation.setValue<String>(
      SharedKeys.applyScholarship,
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> updateNotificationLastSeenTime() async {
    await _sharedOperation.setValue<String>(
      SharedKeys.lastNotificationSeenTime,
      DateTime.now().toIso8601String(),
    );
  }
}

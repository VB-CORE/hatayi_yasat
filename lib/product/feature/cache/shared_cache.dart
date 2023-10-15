import 'package:flutter/material.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';
import 'package:vbaseproject/product/feature/cache/shared_operation.dart';

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

  Future<void> setFirstAppOpen() async {
    await _sharedOperation.setValue(SharedKeys.firstAppOpen, false);
  }

  bool get isFirstAppOpen =>
      _sharedOperation.getValue<bool>(SharedKeys.firstAppOpen) ?? true;

  Future<void> setTheme(ThemeMode mode) async {
    await _sharedOperation.setValue<int>(SharedKeys.theme, mode.index);
  }

  ThemeMode get theme =>
      ThemeMode.values[_sharedOperation.getValue<int>(SharedKeys.theme) ?? 0];

  Future<void> saveApplyScholarshipTime() async {
    await _sharedOperation.setValue<String>(
      SharedKeys.applyScholarship,
      DateTime.now().toIso8601String(),
    );
  }

  DateTime? getApplyScholarshipTime() {
    final time = _sharedOperation.getValue<String>(SharedKeys.applyScholarship);
    if (time == null) return null;
    return DateTime.parse(time);
  }
}

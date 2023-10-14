import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys { firstAppOpen, theme }

final class SharedCache {
  SharedCache._internal();
  static final SharedCache instance = SharedCache._internal();

  late SharedPreferences _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _preferences.clear();
  }

  Future<void> setFirstAppOpen() async {
    await _preferences.setBool(SharedKeys.firstAppOpen.name, false);
  }

  bool get isFirstAppOpen =>
      _preferences.getBool(SharedKeys.firstAppOpen.name) ?? true;

  Future<void> setTheme(ThemeMode mode) async {
    await _preferences.setInt(SharedKeys.theme.name, mode.index);
  }

  ThemeMode get theme =>
      ThemeMode.values[_preferences.getInt(SharedKeys.theme.name) ?? 0];
}

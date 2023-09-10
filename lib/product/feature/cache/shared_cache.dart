import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys { firstAppOpen }

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

  bool isFirstAppOpen() {
    return _preferences.getBool(SharedKeys.firstAppOpen.name) ?? true;
  }
}

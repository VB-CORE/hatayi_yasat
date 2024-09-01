import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedCacheManager extends CacheManager {
  SharedCacheManager({super.path});

  static late SharedPreferences _preferences;

  static SharedPreferences get preferences => _preferences;

  @override
  Future<void> init(List<CacheModel> cacheItems) async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  void remove() {
    _preferences.clear();
  }
}

import 'package:hive/hive.dart';
import 'package:vbaseproject/product/feature/cache/cache_service.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';

abstract class HiveCacheService<T extends Object> extends CacheService<T> {
  int get clearErrorValue => -1;

  @override
  SharedKeys get key;

  Box<T>? _box;

  @override
  Future<void> init() async {
    if (_box != null && (_box?.isOpen ?? false)) return;

    _box = await Hive.openBox<T>(key.name);
  }

  @override
  T? getValue({T? defaultValue}) {
    return _box?.get(key.name, defaultValue: defaultValue);
  }

  @override
  Future<bool> setValue(T value) async {
    await _box?.put(key.name, value);
    return _box?.containsKey(key.name) ?? false;
  }

  @override
  Future<void> deleteValue() async {
    await _box?.delete(key.name);
  }

  @override
  Future<int> clear() async {
    return _box?.clear() ?? Future.value(clearErrorValue);
  }
}

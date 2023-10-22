import 'package:vbaseproject/product/feature/cache/shared_keys.dart';

abstract class CacheService<T extends Object> {
  SharedKeys get key;

  Future<void> init();

  T? getValue({T? defaultValue});

  Future<bool> setValue(T value);

  Future<void> deleteValue();

  Future<int> clear();
}

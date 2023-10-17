import 'package:hive/hive.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/feature/cache/cache_service.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';

abstract class HiveCacheManager<T extends Object> extends CacheService<T> {
  @override
  SharedKeys get key;

  Box<T>? box;

  @override
  Future<void> init() async {
    if (box != null && (box?.isOpen ?? false)) return;

    box = await Hive.openBox(key.name);
  }

  @override
  T? getValue({T? defaultValue}) {
    return box?.get(key.name, defaultValue: defaultValue);
  }

  @override
  Future<bool> setValue(T value) async {
    await box?.put(key.name, value);
    return box?.containsKey(key.name) ?? false;
  }

  @override
  Future<bool> deleteValue() async {
    final count = await box?.clear();
    return (count ?? 0) > 0;
  }
}

abstract class HiveCacheManagerByList<TItem extends Object>
    extends HiveCacheManager<List<TItem>> implements CacheServiceByList<TItem> {
  @override
  TItem? getItemFromList(bool Function(TItem item) condition) {
    final items = getValue();
    return items?.firstWhereOrNull((element) => condition(element));
  }

  @override
  Future<bool> removeItemFromList(bool Function(TItem item) condition) async {
    final items = getValue();
    if (items == null) return false;

    items.removeWhere((element) => condition(element));
    return setValue(items);
  }

  @override
  Future<bool> addItemToList(TItem value) async {
    final items = (getValue() ?? [])..add(value);
    return setValue(items);
  }
}

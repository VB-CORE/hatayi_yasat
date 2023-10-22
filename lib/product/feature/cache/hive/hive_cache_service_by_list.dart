import 'package:hive/hive.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/feature/cache/cache_service.dart';
import 'package:vbaseproject/product/feature/cache/cache_service_by_list.dart';

abstract class HiveCacheServiceByList<TItem extends Object>
    extends CacheService<List<TItem>> implements CacheServiceByList<TItem> {
  Box<List<dynamic>>? _box;

  int get clearErrorValue => -1;

  @override
  Future<void> init() async {
    if (_box != null && (_box?.isOpen ?? false)) return;

    _box = await Hive.openBox<List<dynamic>>(key.name);
  }

  @override
  List<TItem>? getValue({List<TItem>? defaultValue}) {
    return _tryCast(_box?.get(key.name, defaultValue: defaultValue));
  }

  @override
  Future<bool> setValue(List<TItem> value) async {
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

  List<TItem>? _tryCast(List<dynamic>? items) {
    if (items == null) return null;

    try {
      return items.cast<TItem>();
    } catch (_) {
      return null;
    }
  }
}

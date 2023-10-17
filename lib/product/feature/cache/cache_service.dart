import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';

abstract class CacheService<T extends Object> {
  SharedKeys get key;

  Future<void> init();

  T? getValue({T? defaultValue});

  Future<bool> setValue(T value);

  Future<bool> deleteValue();
}

abstract class CacheServiceByList<TItem extends Object>
    extends CacheService<List<TItem>> {
  TItem? getItemFromList(bool Function(TItem item) condition) {
    final items = getValue();
    return items?.firstWhereOrNull((element) => condition(element));
  }

  Future<bool> removeItemFromList(bool Function(TItem item) condition) async {
    final items = getValue();
    if (items == null) return false;

    items.removeWhere((element) => condition(element));
    return setValue(items);
  }

  Future<bool> addItemToList(TItem value) async {
    final items = (getValue() ?? [])..add(value);
    return setValue(items);
  }
}

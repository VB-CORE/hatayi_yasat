import 'package:hive/hive.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/cache_manager.dart';

final class HiveOperationManager<T extends CacheModel>
    extends CacheOperation<T> {
  HiveOperationManager() {
    _box = Hive.box<T>(
      name: T.toString(),
    );
  }

  late final Box<T> _box;

  @override
  void add(T data) {
    _box.put(data.id, data);
  }

  @override
  void delete(T data) {
    _box.delete(data.id);
  }

  @override
  T? get(String id) {
    return _box.get(id);
  }

  @override
  List<T> getAll() {
    return _box
        .getAll(_box.keys.toList())
        .where((element) => element != null)
        .cast<T>()
        .toList();
  }

  @override
  void update(T data) {
    _box.put(data.id, data);
  }

  @override
  bool removeAll() {
    _box.clear();
    final itemList = getAll();
    return itemList.isEmpty;
  }
}

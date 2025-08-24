import 'package:hive_ce/hive.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';

final class HiveOperationManager<T extends CacheModel>
    extends CacheOperation<T> {
  HiveOperationManager() {
    _initializeBox();
  }

  Box<T>? _box;

  Future<void> _initializeBox() async {
    if (!Hive.isBoxOpen(T.toString())) {
      await Hive.openBox<T>(T.toString());
    }
    _box = Hive.box(T.toString());
  }

  @override
  void add(T data) {
    _box?.put(data.id, data);
  }

  @override
  void delete(T data) {
    _box?.delete(data.id);
  }

  @override
  T? get(String id) {
    final value = _box?.get(id);
    return value is T ? value : null;
  }

  @override
  List<T> getAll() {
    final values = _box?.values.toList() ?? [];
    return values.whereType<T>().toList();
  }

  @override
  void update(T data) {
    _box?.put(data.id, data);
  }

  @override
  Future<bool> removeAll() async {
    await _box?.clear();
    final itemList = getAll();
    return itemList.isEmpty;
  }
}

import 'package:hive_ce/hive.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';

final class HiveOperationManager<T extends CacheModel>
    extends CacheOperation<T> {
  /// [boxName] defaults to the type name. Pass an explicit one when a model's
  /// stored shape changes, so entries written by an older adapter are orphaned
  /// instead of being read back as garbage.
  HiveOperationManager({String? boxName}) : _boxName = boxName ?? T.toString() {
    _ready = _initializeBox();
  }

  final String _boxName;

  Box<T>? _box;
  late final Future<void> _ready;

  @override
  Future<void> get ready => _ready;

  Future<void> _initializeBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<T>(_boxName);
    }
    _box = Hive.box(_boxName);
  }

  @override
  void add(T data) => _box?.put(data.id, data);

  @override
  void delete(T data) => _box?.delete(data.id);

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
  void update(T data) => _box?.put(data.id, data);

  @override
  Future<bool> removeAll() async {
    await _box?.clear();
    final itemList = getAll();
    return itemList.isEmpty;
  }
}

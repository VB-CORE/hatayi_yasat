import 'package:life_shared/life_shared.dart';

export 'package:life_shared/life_shared.dart' show CacheModel;

abstract class CacheManager {
  CacheManager({this.path});

  Future<void> init();
  void remove();

  final String? path;
}

abstract class CacheOperation<T extends CacheModel> {
  Future<void> init();

  void add(T data);
  void delete(T data);
  void update(T data);
  List<T> getAll();
  T? get(String id);
  Future<bool> removeAll();
}

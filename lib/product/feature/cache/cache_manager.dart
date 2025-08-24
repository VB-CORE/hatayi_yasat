abstract class CacheManager {
  CacheManager({this.path});

  Future<void> init(List<CacheModel> cacheItems);
  void remove();

  final String? path;
}

mixin CacheModel {
  String get id;

  CacheModel fromDynamicJson(dynamic json);
  Map<String, dynamic> toJson();
}

abstract class CacheOperation<T extends CacheModel> {
  void add(T data);
  void delete(T data);
  void update(T data);
  List<T> getAll();
  T? get(String id);
  Future<bool> removeAll();
}

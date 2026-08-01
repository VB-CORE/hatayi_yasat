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
  /// Completes once the underlying storage has finished opening.
  /// Await this before calling [getAll]/[get] if the result must reflect
  /// previously persisted data.
  Future<void> get ready;

  void add(T data);
  void delete(T data);
  void update(T data);
  List<T> getAll();
  T? get(String id);
  Future<bool> removeAll();
}

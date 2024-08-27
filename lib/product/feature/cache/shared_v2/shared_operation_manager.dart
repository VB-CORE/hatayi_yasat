import 'dart:convert';

import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPrefsOperationManager<T extends CacheModel>
    extends CacheOperation<T> {
  SharedPrefsOperationManager({
    required SharedPreferences preferences,
    required T cacheModel,
  })  : _preferences = preferences,
        _cacheModel = cacheModel;

  final SharedPreferences _preferences;
  final T _cacheModel;

  @override
  Future<void> add(T data) async {
    await _preferences.setString(data.id, jsonEncode(data.toJson()));
  }

  @override
  Future<void> delete(T data) async {
    await _preferences.remove(data.id);
  }

  @override
  Future<void> update(T data) async {
    await add(data);
  }

  @override
  List<T> getAll() {
    final keys = _preferences.getKeys();
    final items = <T>[];
    for (final key in keys) {
      final jsonString = _preferences.get(key);
      if (jsonString != null && jsonString is String) {
        items.add(_cacheModel.fromDynamicJson(jsonDecode(jsonString)) as T);
      }
    }
    return items;
  }

  @override
  T? get(String id) {
    final jsonString = _preferences.getString(id);
    if (jsonString == null) return null;
    final data = _cacheModel.fromDynamicJson(jsonDecode(jsonString));
    return data as T;
  }

  @override
  bool removeAll() {
    final keys = _preferences.getKeys();

    /// TODO: it will update
    Future.forEach(keys, (element) async {
      await _preferences.remove(element);
    });

    return true;
  }
}

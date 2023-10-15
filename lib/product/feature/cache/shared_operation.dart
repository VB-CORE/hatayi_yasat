// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';

abstract class BaseSharedOperation {
  SharedPreferences get _sharedPreferences;

  Future<void> init();
  Future<void> setValue<T>(SharedKeys key, T value);
  T? getValue<T>(SharedKeys key);
  Future<void> delete(SharedKeys key);
  Future<void> clear();
}

final class SharedOperation extends BaseSharedOperation
    with SharedOperationGenericMixin {
  @override
  late SharedPreferences _sharedPreferences;

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setValue<T>(SharedKeys key, T value) async {
    await saveWithGeneric<T>(key, value);
  }

  @override
  T? getValue<T>(SharedKeys key) {
    return readWithGeneric<T>(key);
  }

  @override
  Future<void> delete(SharedKeys key) async {
    await _sharedPreferences.remove(key.name);
  }

  @override
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}

mixin SharedOperationGenericMixin on BaseSharedOperation {
  Future<void> saveWithGeneric<T>(SharedKeys key, T value) async {
    if (value is bool) {
      await _sharedPreferences.setBool(key.name, value);
      return;
    }

    if (value is int) {
      await _sharedPreferences.setInt(key.name, value);
      return;
    }

    if (value is double) {
      await _sharedPreferences.setDouble(key.name, value);
      return;
    }

    if (value is String) {
      await _sharedPreferences.setString(key.name, value);
      return;
    }

    if (value is List<String>) {
      await _sharedPreferences.setStringList(key.name, value);
      return;
    }

    throw Exception('SharedOperation: Type is not supported');
  }

  T? readWithGeneric<T>(SharedKeys key) {
    if (T == bool) {
      return _sharedPreferences.getBool(key.name) as T?;
    }

    if (T == int) {
      return _sharedPreferences.getInt(key.name) as T?;
    }

    if (T == double) {
      return _sharedPreferences.getDouble(key.name) as T?;
    }

    if (T == String) {
      return _sharedPreferences.getString(key.name) as T?;
    }

    if (T == List<String>) {
      return _sharedPreferences.getStringList(key.name) as T?;
    }

    throw Exception('SharedOperation: Type is not supported');
  }
}

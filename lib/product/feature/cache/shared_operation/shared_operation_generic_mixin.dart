part of 'base_shared_operation.dart';

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

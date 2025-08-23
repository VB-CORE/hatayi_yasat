import 'package:lifeclient/product/feature/cache/shared_operation/shared_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_operation_generic_mixin.dart';

abstract class BaseSharedOperation {
  SharedPreferences get _sharedPreferences;

  Future<void> init();
  Future<void> setValue<T>(SharedKeys key, T value);
  Future<bool> setStringList(SharedKeys key, List<String> value);
  List<String>? getStringList(SharedKeys key);
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

  @override
  Future<bool> setStringList(SharedKeys key, List<String> value) {
    return _sharedPreferences.setStringList(key.name, value);
  }

  @override
  List<String>? getStringList(SharedKeys key) {
    return _sharedPreferences.getStringList(key.name);
  }
}

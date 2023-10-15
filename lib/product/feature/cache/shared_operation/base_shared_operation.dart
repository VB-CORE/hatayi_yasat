import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';

part 'shared_operation_generic_mixin.dart';

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

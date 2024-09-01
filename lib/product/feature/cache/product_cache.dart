import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:lifeclient/product/feature/cache/shared_v2/shared_cache_manager.dart';
import 'package:lifeclient/product/feature/cache/shared_v2/shared_operation_manager.dart';

final class ProductCache {
  ProductCache({required CacheManager cacheManager})
      : _cacheManager = cacheManager;

  final CacheManager _cacheManager;

  Future<void> init() async {
    await _cacheManager.init([
      StoreModelCache.empty(),
      const AppCacheModel(),
    ]);
  }

  //TODO: It will change to hive before release!!
  late final CacheOperation<StoreModelCache> storeModelCache =
      SharedPrefsOperationManager<StoreModelCache>(
    cacheModel: StoreModelCache.empty(),
    preferences: SharedCacheManager.preferences,
  );

  late final CacheOperation<AppCacheModel> appModelCache =
      SharedPrefsOperationManager<AppCacheModel>(
    cacheModel: const AppCacheModel(),
    preferences: SharedCacheManager.preferences,
  );
}

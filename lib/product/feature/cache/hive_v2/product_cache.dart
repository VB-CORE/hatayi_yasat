import 'package:vbaseproject/product/feature/cache/hive_v2/cache_manager.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/hive_opeartion_manager.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/model/store_model_cache.dart';

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

  late final HiveOperationManager<StoreModelCache> storeModelCache =
      HiveOperationManager<StoreModelCache>();

  late final HiveOperationManager<AppCacheModel> appModelCache =
      HiveOperationManager<AppCacheModel>();
}

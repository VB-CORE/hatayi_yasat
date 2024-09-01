import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_opeartion_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';

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

  /// hive
  late final CacheOperation<StoreModelCache> storeModelCache =
      HiveOperationManager<StoreModelCache>();

  late final CacheOperation<AppCacheModel> appModelCache =
      HiveOperationManager<AppCacheModel>();

  // //shared
  // late final CacheOperation<StoreModelCache> storeModelCache =
  //     SharedPrefsOperationManager<StoreModelCache>(
  //   cacheModel: StoreModelCache.empty(),
  //   preferences: SharedCacheManager.preferences,
  // );

  // late final CacheOperation<AppCacheModel> appModelCache =
  //     SharedPrefsOperationManager<AppCacheModel>(
  //   cacheModel: const AppCacheModel(),
  //   preferences: SharedCacheManager.preferences,
  // );
}

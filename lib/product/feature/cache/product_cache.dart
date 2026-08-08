import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_opeartion_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/memory_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/news_bookmark_cache.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';

final class ProductCache {
  ProductCache({required CacheManager cacheManager})
      : _cacheManager = cacheManager;

  final CacheManager _cacheManager;

  Future<void> init() async {
    await _cacheManager.init([
      StoreModelCache.empty(),
      const AppCacheModel(),
      const MemoryCacheModel.empty(),
      const NewsBookmarkCache.empty(),
      const UserModel.empty(),
    ]);
  }

  /// hive
  late final CacheOperation<StoreModelCache> storeModelCache =
      HiveOperationManager<StoreModelCache>();

  late final CacheOperation<AppCacheModel> appModelCache =
      HiveOperationManager<AppCacheModel>();

  late final CacheOperation<MemoryCacheModel> memoryCacheModel =
      HiveOperationManager<MemoryCacheModel>();

  late final CacheOperation<NewsBookmarkCache> newsBookmarkCache =
      HiveOperationManager<NewsBookmarkCache>(boxName: 'NewsBookmarkCache_v2');

  late final CacheOperation<UserModel> userCache =
      HiveOperationManager<UserModel>(boxName: 'UserModel_v6');
}

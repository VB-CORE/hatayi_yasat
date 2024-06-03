import 'package:hive/hive.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:path_provider/path_provider.dart';

final class HiveCacheManager extends CacheManager {
  HiveCacheManager({super.path});

  @override
  Future<void> init(List<CacheModel> cacheItems) async {
    final directoryPath =
        path ?? (await getApplicationDocumentsDirectory()).path;
    Hive.defaultDirectory = directoryPath;

    _register();
  }

  void _register() {
    Hive.registerAdapter<StoreModelCache>(
      '$StoreModelCache',
      StoreModelCache.empty().fromDynamicJson,
    );

    Hive.registerAdapter<AppCacheModel>(
      '$AppCacheModel',
      (json) => const AppCacheModel().fromDynamicJson(json),
    );
  }

  @override
  void remove() {
    Hive.deleteAllBoxesFromDisk();
  }
}

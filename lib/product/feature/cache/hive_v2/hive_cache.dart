import 'package:hive_ce/hive.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_registrar.g.dart';
import 'package:path_provider/path_provider.dart';

final class HiveCacheManager extends CacheManager {
  HiveCacheManager({super.path});

  @override
  Future<void> init(List<CacheModel> cacheItems) async {
    final directoryPath =
        path ?? (await getApplicationDocumentsDirectory()).path;
    Hive.init(directoryPath);

    _register();
  }

  void _register() {
    Hive.registerAdapters();
  }

  @override
  void remove() {
    Hive.deleteFromDisk();
  }
}

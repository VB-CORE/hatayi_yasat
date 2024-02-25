import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/cache_manager.dart';

final class HiveCacheManager extends CacheManager {
  HiveCacheManager({super.path});

  @override
  Future<void> init(List<CacheModel> cacheItems) async {
    final directoryPath =
        path ?? (await getApplicationDocumentsDirectory()).path;
    Hive.defaultDirectory = directoryPath;

    for (final element in cacheItems) {
      Hive.registerAdapter(
        '${element.runtimeType}',
        element.fromDynamicJson,
      );
    }
  }

  @override
  void remove() {
    Hive.deleteAllBoxesFromDisk();
  }
}

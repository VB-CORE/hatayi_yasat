import 'package:hive_ce/hive.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_registrar.g.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/home_path/hive_home_path_io.dart'
    if (dart.library.js_interop) 'package:lifeclient/product/feature/cache/hive_v2/home_path/hive_home_path_web.dart';

final class HiveCacheManager extends CacheManager {
  HiveCacheManager({super.path});

  @override
  Future<void> init() async {
    Hive.init(path ?? await const PlatformHiveHomePath().resolve());

    _register();
  }

  void _register() {
    Hive.registerAdapters();
  }

  @override
  void remove() => Hive.deleteFromDisk();
}

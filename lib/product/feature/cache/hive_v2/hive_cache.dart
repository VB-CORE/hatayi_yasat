import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_registrar.g.dart';
import 'package:path_provider/path_provider.dart';

final class HiveCacheManager extends CacheManager {
  HiveCacheManager({super.path});

  @override
  Future<void> init() async {
    Hive.init(await _resolveHomePath());

    _register();
  }

  /// Web'de hive_ce IndexedDB kullanır, home path'i yok sayar.
  Future<String?> _resolveHomePath() async {
    if (path != null) return path;
    if (kIsWeb) return null;
    return (await getApplicationDocumentsDirectory()).path;
  }

  void _register() {
    Hive.registerAdapters();
  }

  @override
  void remove() => Hive.deleteFromDisk();
}

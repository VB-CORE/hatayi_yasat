import 'package:lifeclient/product/feature/cache/hive_v2/home_path/hive_home_path.dart';

final class PlatformHiveHomePath implements HiveHomePath {
  const PlatformHiveHomePath();

  /// hive_ce's IndexedDB backend ignores the home path.
  @override
  Future<String?> resolve() async => null;
}

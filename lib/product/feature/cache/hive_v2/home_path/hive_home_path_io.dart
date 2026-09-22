import 'package:lifeclient/product/feature/cache/hive_v2/home_path/hive_home_path.dart';
import 'package:path_provider/path_provider.dart';

final class PlatformHiveHomePath implements HiveHomePath {
  const PlatformHiveHomePath();

  @override
  Future<String?> resolve() async =>
      (await getApplicationDocumentsDirectory()).path;
}

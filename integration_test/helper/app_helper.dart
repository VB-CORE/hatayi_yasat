import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';

final class AppHelper {
  static bool isOnboardCompleted() {
    return SharedCache.instance.isFirstAppOpen;
  }
}

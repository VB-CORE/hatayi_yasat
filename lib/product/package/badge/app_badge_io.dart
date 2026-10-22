import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:lifeclient/product/package/badge/app_badge.dart';

final class PlatformAppBadge implements AppBadge {
  const PlatformAppBadge();

  @override
  Future<bool> isSupported() => AppBadgePlus.isSupported();

  @override
  Future<void> update(int count) => AppBadgePlus.updateBadge(count);
}

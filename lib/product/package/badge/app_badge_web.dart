import 'package:lifeclient/product/package/badge/app_badge.dart';

final class PlatformAppBadge implements AppBadge {
  const PlatformAppBadge();

  @override
  Future<bool> isSupported() async => false;

  @override
  Future<void> update(int count) async {}
}

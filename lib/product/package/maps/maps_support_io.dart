import 'package:lifeclient/product/package/maps/maps_support.dart';

final class PlatformMapsSupport implements MapsSupport {
  const PlatformMapsSupport();

  @override
  Future<void> load() async {}

  @override
  bool get supportsMyLocation => true;
}

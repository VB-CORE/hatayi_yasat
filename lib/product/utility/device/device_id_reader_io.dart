import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/device/device_id_reader.dart';

final class PlatformDeviceIdReader implements DeviceIdReader {
  const PlatformDeviceIdReader();

  @override
  Future<String?> read() => DeviceUtility.instance.getUniqueDeviceId();
}

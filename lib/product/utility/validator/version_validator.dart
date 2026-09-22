import 'package:lifeclient/product/model/enum/firebase_remote_enums.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class VersionValidator {
  VersionValidator._init();

  static Future<bool> check() async {
    final remoteVersion = FirebaseRemoteEnums.version.valueString;
    if (remoteVersion.isEmpty) return false;

    final currentVersion = (await PackageInfo.fromPlatform()).version;
    final currentVersionNumber = int.parse(currentVersion.split('.').join());
    final remoteVersionNumber = int.parse(remoteVersion.split('.').join());

    return remoteVersionNumber > currentVersionNumber;
  }
}

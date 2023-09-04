import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:kartal/kartal.dart';

import 'package:vbaseproject/product/model/enum/firebase_remote_enums.dart';

final class VersionValidator {
  VersionValidator._init();
  static bool check() {
    final currentVersion = ''.ext.version;
    final remoteVersion = FirebaseRemoteEnums.version.value;
    final x = FirebaseRemoteConfig.instance.getValue('version').source;
    if (remoteVersion.isEmpty) return false;
    final currentVersionNumber = int.parse(currentVersion.split('.').join());
    final remoteVersionNumber = int.parse(remoteVersion.split('.').join());

    if (remoteVersionNumber > currentVersionNumber) {
      return true;
    }
    return false;
  }
}

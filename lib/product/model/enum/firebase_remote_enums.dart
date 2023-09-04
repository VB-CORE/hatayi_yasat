import 'package:firebase_remote_config/firebase_remote_config.dart';

enum FirebaseRemoteEnums {
  version;

  String get value {
    return FirebaseRemoteConfig.instance.getString(name);
  }
}

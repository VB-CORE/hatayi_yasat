import 'package:firebase_remote_config/firebase_remote_config.dart';

enum FirebaseRemoteEnums {
  specialDay,
  version;

  String get valueString => FirebaseRemoteConfig.instance.getString(name);

  bool get valueBool => FirebaseRemoteConfig.instance.getBool(name);
}

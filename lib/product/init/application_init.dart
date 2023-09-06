import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:vbaseproject/core/init/core_localize.dart';

import 'package:vbaseproject/firebase_options.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_utility.dart';

@immutable
final class ApplicationInit {
  ApplicationInit();

  final CoreLocalize localize = CoreLocalize();

  /// The start function is a future that does not return any
  /// value and can be awaited.
  Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await DeviceUtility.instance.initPackageInfo();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();

    await MessagingUtility.init();
  }
}

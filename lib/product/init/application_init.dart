import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/core/init/core_localize.dart';
import 'package:vbaseproject/firebase_options.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/model/enum/firebase_env.dart';

@immutable
final class ApplicationInit {
  ApplicationInit();

  final CoreLocalize localize = CoreLocalize();

  /// The start function is a future that does not return any
  /// value and can be awaited.
  Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await _setRotation();
    await DeviceUtility.instance.initPackageInfo();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();

    await SharedCache.instance.init();
    await _injectTestEnvOnDebug();
    await _crashlyticsInitialize();
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(kDebugMode);
  }

  Future<void> _injectTestEnvOnDebug() async {
    if (kDebugMode) return;
    await FirebaseStorage.instance.useStorageEmulator(
      FirebaseEnv.localPath,
      FirebaseEnv.storage.port,
    );
    FirebaseFirestore.instance.useFirestoreEmulator(
      FirebaseEnv.localPath,
      FirebaseEnv.firestore.port,
    );
  }

  Future<void> _crashlyticsInitialize() async {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
  }

  Future<void> _setRotation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

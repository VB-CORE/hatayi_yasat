import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/dependency/project_dependency.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/init/core_localize.dart';
import 'package:lifeclient/firebase_options.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/model/enum/firebase_env.dart';

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
    // await _injectTestEnvOnDebug();
    await _crashlyticsInitialize();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    ProjectDependency.setup();
    ProjectDependencyItems.appProvider
        .changeAppTheme(theme: SharedCache.instance.theme);
    // await _injectTestEnvOnDebug();
  }

  Future<void> _injectTestEnvOnDebug() async {
    if (!kDebugMode) return;
    FirebaseFunctions.instance.useFunctionsEmulator(
      FirebaseEnv.localPath,
      FirebaseEnv.functions.port,
    );
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

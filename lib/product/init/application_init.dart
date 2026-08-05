import 'dart:async';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:lifeclient/core/service/analytics/firebase_analytics_service.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';
import 'package:lifeclient/firebase_options.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';

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

    if (kDebugMode) {
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false,
      );
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 3004);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 3000);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 3005);
    }

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();

    await SharedCache.instance.init();
    // await _injectTestEnvOnDebug();
    _bindErrorHandlers();

    ProjectDependency.setup();
    await ProjectDependencyItems.analyticsService.setCollectionEnabled(
      enabled: FirebaseAnalyticsService.isEnabled,
    );
    await ProjectDependencyItems.analyticsService.setUserProperty(
      AnalyticsUserProperty.appTheme,
      SharedCache.instance.theme.name,
    );
    await ProjectDependencyItems.productCache.init();
    // ProjectDependencyItems.appProvider
    //     .changeAppTheme(theme: SharedCache.instance.theme);
    // await _injectTestEnvOnDebug();
  }

  void _bindErrorHandlers() {
    FlutterError.onError = (errorDetails) {
      // Without this the console stack trace and red error screen are lost.
      FlutterError.presentError(errorDetails);
      unawaited(
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails),
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
      );
      return true;
    };

    Isolate.current.addErrorListener(
      RawReceivePort((List<dynamic> pair) {
        final [error as Object, stack as String] = pair;
        unawaited(
          FirebaseCrashlytics.instance.recordError(
            error,
            StackTrace.fromString(stack),
            fatal: true,
          ),
        );
      }).sendPort,
    );
  }

  Future<void> _setRotation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

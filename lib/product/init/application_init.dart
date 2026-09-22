import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeclient/core/dependency/project_dependency.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/init/core_localize.dart';
import 'package:lifeclient/core/service/analytics/firebase_analytics_service.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_user_property.dart';
import 'package:lifeclient/firebase_options.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/init/app_check_initialize.dart';
import 'package:lifeclient/product/init/error_handler/error_handler_binder_io.dart'
    if (dart.library.js_interop) 'package:lifeclient/product/init/error_handler/error_handler_binder_web.dart';

@immutable
final class ApplicationInit {
  ApplicationInit();

  final CoreLocalize localize = CoreLocalize();

  Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await _setRotation();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await AppCheckInitialize.activate();

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();

    await SharedCache.instance.init();
    const PlatformErrorHandlerBinder().bind();

    ProjectDependency.setup();
    await ProjectDependencyItems.analyticsService.setCollectionEnabled(
      enabled: FirebaseAnalyticsService.isEnabled,
    );
    ProjectDependencyItems.analyticsService.setUserProperty(
      AnalyticsUserProperty.appTheme,
      SharedCache.instance.theme.name,
    );
    await ProjectDependencyItems.productCache.init();
  }

  Future<void> _setRotation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

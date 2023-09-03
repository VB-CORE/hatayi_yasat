import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/settings/settings_view.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/product/app_builder.dart';
import 'package:vbaseproject/product/init/application_init.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';

void main() async {
  final initialManager = ApplicationInit();
  await initialManager.start();
  runApp(
    EasyLocalization(
      supportedLocales: initialManager.localize.supportedItems,
      path: initialManager.localize.initialPath,
      useOnlyLangCode: true,
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: AppBuilder.build,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.black,
        ),
      ),
      scaffoldMessengerKey:
          ref.read(AppProvider.provider.notifier).scaffoldMessengerKey,
      home: const SplashView(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  //Added because page view was not scrolling via mouse in web
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

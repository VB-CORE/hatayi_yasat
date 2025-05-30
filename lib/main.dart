import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/app.dart';
import 'package:lifeclient/product/init/application_init.dart';

Future<void> main() async {
  final initialManager = ApplicationInit();
  await initialManager.start();
  runApp(
    EasyLocalization(
      supportedLocales: initialManager.localize.supportedItems,
      path: initialManager.localize.initialPath,
      startLocale: initialManager.localize.startLocale,
      useOnlyLangCode: true,
      child: ProviderScope(child: App()),
    ),
  );
}

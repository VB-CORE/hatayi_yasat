import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/v2/app.dart';
import 'package:vbaseproject/product/init/application_init.dart';

void main() async {
  final initialManager = ApplicationInit();

  /// await olmadan çalıştıralim
  await initialManager.start();
  runApp(
    EasyLocalization(
      supportedLocales: initialManager.localize.supportedItems,
      path: initialManager.localize.initialPath,
      startLocale: initialManager.localize.startLocale,
      useOnlyLangCode: true,
      child: const ProviderScope(child: App()),
    ),
  );
}

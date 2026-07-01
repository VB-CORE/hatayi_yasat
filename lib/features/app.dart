import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/product/app_builder.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/navigation/router_notifier.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/product/widget/builder/keyboard_focus_control_widget.dart';

final class App extends ConsumerWidget with AppProviderStateMixin {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationTheme = ApplicationTheme.build();
    final router = ref.watch(goRouterProvider);

    return KeyboardFocusControlWidget(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: AppBuilder.build,
        themeMode: appStateWatch(ref).theme,
        theme: applicationTheme.lightThemeData,
        darkTheme: applicationTheme.darkThemeData,
        scaffoldMessengerKey: appProvider(ref).scaffoldMessengerKey,
        // home: NewsDetailView(news: NewsModel.dummyData),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/product/app_builder.dart';
import 'package:vbaseproject/product/init/application_theme.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';

final class App extends ConsumerWidget with AppProviderStateMixin<App> {
  App({super.key});

  final _router = GoRouter(
    routes: $appRoutes,
    initialLocation: '/',
    redirect: (context, state) {
      return null;
    },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: AppBuilder.build,
      themeMode: appStateWatch(ref).theme,
      theme: ApplicationTheme.build(context).themeData,
      scaffoldMessengerKey:
          ref.read(AppProvider.provider.notifier).scaffoldMessengerKey,
      // home: NewsDetailView(news: NewsModel.dummyData),
    );
  }
}

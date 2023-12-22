import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/sub_feature/tab/main_tab_view.dart';

final class MainTabRoute extends GoRouteData {
  const MainTabRoute();
  static const route = TypedGoRoute<MainTabRoute>(
    path: 'mainTab',
    name: 'Main Tabs',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MainTabView();
}

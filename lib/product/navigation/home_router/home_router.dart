import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/v2/home/view/home_view.dart';

final class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const route = TypedGoRoute<HomeRoute>(
    path: 'home',
    name: 'Home',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeView();
}

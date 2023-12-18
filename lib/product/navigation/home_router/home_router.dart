import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/place_request_model.dart';

final class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const route = TypedGoRoute<HomeRoute>(
    path: '/home',
    name: 'Home',
    routes: [
      HomeDetailRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) => const Text('data');
}

final class HomeDetailRoute extends GoRouteData {
  HomeDetailRoute({required this.$extra});

  static const route = TypedGoRoute<HomeDetailRoute>(
    path: 'detail',
    name: 'Home detail',
  );

  final PlaceRequestModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => const Text('data');
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/v2/favorite/view/favorite_view.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';

final class FavoriteRoute extends GoRouteData {
  const FavoriteRoute();

  static const route = TypedGoRoute<FavoriteRoute>(
    path: '/favorite',
    name: 'Favorite',
    routes: [
      PlaceDetailRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FavoriteView();
}

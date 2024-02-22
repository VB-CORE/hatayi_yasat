import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/favorite/view/favorite_view.dart';

final class FavoriteRoute extends GoRouteData {
  const FavoriteRoute();

  static const route = TypedGoRoute<FavoriteRoute>(
    path: 'favorite',
    name: 'Favorite',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FavoriteView();
}

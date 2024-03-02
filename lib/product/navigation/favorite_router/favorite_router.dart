import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/sub_feature/favorite/view/favorite_view.dart';

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

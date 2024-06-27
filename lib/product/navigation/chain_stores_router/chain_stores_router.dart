import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/chain_store/view/chain_store_view.dart';
import 'package:lifeclient/features/tourism/view/tourism_map_view.dart';

final class ChainStoresRoute extends GoRouteData {
  const ChainStoresRoute();

  static const route = TypedGoRoute<ChainStoresRoute>(
    path: 'chain_stores',
    name: 'Chain Stores',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChainStoreView();
}

final class TurismRoute extends GoRouteData {
  const TurismRoute();

  static const route = TypedGoRoute<TurismRoute>(
    path: 'turism',
    name: 'Turism items',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TourismMapView();
}

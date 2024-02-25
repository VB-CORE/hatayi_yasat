import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/chain_stores/view/chain_stores_view.dart';

final class ChainStoresRoute extends GoRouteData {
  const ChainStoresRoute();

  static const route = TypedGoRoute<ChainStoresRoute>(
    path: 'chain_stores',
    name: 'Chain Stores',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChainStoresView();
}

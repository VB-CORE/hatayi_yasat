import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/sub_feature/useful_links/view/useful_links_view.dart';

final class UsefulLinksRoute extends GoRouteData {
  const UsefulLinksRoute();

  static const route = TypedGoRoute<UsefulLinksRoute>(
    path: 'useful_links',
    name: 'Useful Links',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UsefulLinksView();
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/sub_feature/developers/view/developers_view.dart';

final class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  static const route = TypedGoRoute<SettingsRoute>(
    path: 'settings',
    name: 'Settings',
    routes: [
      DevelopersRoute.route,
      ApplicationInformationRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) => const Text('data');
}

final class DevelopersRoute extends GoRouteData {
  const DevelopersRoute();

  static const route = TypedGoRoute<DevelopersRoute>(
    path: 'developers',
    name: 'Developers',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DevelopersView();
}

final class ApplicationInformationRoute extends GoRouteData {
  const ApplicationInformationRoute();

  static const route = TypedGoRoute<ApplicationInformationRoute>(
    path: 'appInfo',
    name: 'Application Information',
  );

  @override
  // TODO: Bu sayfa yapılacak.
  Widget build(BuildContext context, GoRouterState state) =>
      const Text('Bu sayfa yapılacak.');
}

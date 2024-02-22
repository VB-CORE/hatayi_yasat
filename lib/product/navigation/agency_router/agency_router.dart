import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/special_agency/view/special_agency_view.dart';

final class SpecialAgencyRoute extends GoRouteData {
  const SpecialAgencyRoute();

  static const route = TypedGoRoute<SpecialAgencyRoute>(
    path: 'specialAgency',
    name: 'Special Agency',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SpecialAgencyView();
}

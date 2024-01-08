import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/sub_feature/onboard/on_board_view.dart';

final class OnboardRoute extends GoRouteData {
  const OnboardRoute();

  static const route = TypedGoRoute<OnboardRoute>(
    path: 'onboard',
    name: 'Onboard',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnBoardView();
}

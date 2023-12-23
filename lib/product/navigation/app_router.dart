import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/features/v2/details/view/place_detail_view.dart';
import 'package:vbaseproject/product/navigation/agency_router/agency_router.dart';
import 'package:vbaseproject/product/navigation/favorite_router/favorite_router.dart';
import 'package:vbaseproject/product/navigation/main_tab_router/main_tab_router.dart';
import 'package:vbaseproject/product/navigation/news_jobs_router/news_jobs_router.dart';
import 'package:vbaseproject/product/navigation/onboard_router/onboard_router.dart';
import 'package:vbaseproject/product/navigation/settings_router/settings_router.dart';

part 'app_router.g.dart';

@TypedGoRoute<SplashRoute>(
  path: '/',
  routes: [
    OnboardRoute.route,
    FavoriteRoute.route,
    SpecialAgencyRoute.route,
    PlaceDetailRoute.route,
    MainTabRoute.route,
    DevelopersRoute.route,
    NewsJobsRoute.route,
  ],
)
final class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashView();
}

/// You can use this route for home and favorite place cards
final class PlaceDetailRoute extends GoRouteData {
  PlaceDetailRoute({required this.$extra});

  static const route = TypedGoRoute<PlaceDetailRoute>(
    path: 'placeDetail',
    name: 'Place Detail',
  );

  final StoreModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PlaceDetailView(model: $extra);
}

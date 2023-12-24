import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/features/v2/details/view/place_detail_view.dart';
import 'package:vbaseproject/features/v2/sub_feature/filter_and_search/view/filter_search_view.dart';
import 'package:vbaseproject/product/navigation/agency_router/agency_router.dart';
import 'package:vbaseproject/product/navigation/favorite_router/favorite_router.dart';
import 'package:vbaseproject/product/navigation/news_jobs_router/news_jobs_router.dart';
import 'package:vbaseproject/product/navigation/onboard_router/onboard_router.dart';
import 'package:vbaseproject/product/navigation/settings_router/settings_router.dart';
import 'package:vbaseproject/sub_feature/tab/main_tab_view.dart';

part 'app_router.g.dart';

@TypedGoRoute<SplashRoute>(
  path: '/',
  routes: [
    OnboardRoute.route,
  ],
)
final class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashView();
}

@TypedGoRoute<MainTabRoute>(
  path: '/main',
  routes: [
    FavoriteRoute.route,
    SpecialAgencyRoute.route,
    PlaceDetailRoute.route,
    DevelopersRoute.route,
    NewsJobsRoute.route,
    FilterRoute.route,
  ],
)
final class MainTabRoute extends GoRouteData {
  const MainTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MainTabView();
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

final class FilterRoute extends GoRouteData {
  const FilterRoute();

  static const route = TypedGoRoute<FilterRoute>(
    path: 'filter',
    name: 'Filter',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FilterSearchView();
}

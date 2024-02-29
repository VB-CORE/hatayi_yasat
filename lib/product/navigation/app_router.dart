import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/details/view/place_detail_view.dart';
import 'package:lifeclient/features/splash/splash_view.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/model/filter_selected.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/filter_result_view.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/filter_search_view.dart';
import 'package:lifeclient/features/sub_feature/forms/index.dart';
import 'package:lifeclient/features/sub_feature/notifications/notifications_view.dart';
import 'package:lifeclient/product/model/news_model_copy.dart';
import 'package:lifeclient/product/navigation/agency_router/agency_router.dart';
import 'package:lifeclient/product/navigation/event_router/event_router.dart';
import 'package:lifeclient/product/navigation/favorite_router/favorite_router.dart';
import 'package:lifeclient/product/navigation/news_jobs_router/news_jobs_router.dart';
import 'package:lifeclient/product/navigation/onboard_router/onboard_router.dart';
import 'package:lifeclient/product/navigation/settings_router/settings_router.dart';
import 'package:lifeclient/sub_feature/tab/main_tab_view.dart';

export 'package:life_shared/life_shared.dart' show NewsModel;

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
    EventRoute.route,
    NotificationsRoute.route,
    FilterResultRoute.route,

    // Forms
    PlaceRequestFormRoute.route,
    ProjectRequestFormRoute.route,
    ScholarShipRequestFormRoute.route,
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
  PlaceDetailRoute({required this.$extra, required this.id});

  static const route = TypedGoRoute<PlaceDetailRoute>(
    path: 'placeDetail/:id',
    name: 'Place Detail',
  );

  final StoreModel $extra;
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) => PlaceDetailView(
        model: $extra,
        id: id,
      );
}

final class FilterRoute extends GoRouteData {
  const FilterRoute({
    this.$extra,
  });

  static const route = TypedGoRoute<FilterRoute>(
    path: 'filter',
    name: 'Filter',
  );

  final String? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => FilterSearchView(
        selectedCategoryId: $extra,
      );
}

final class FilterResultRoute extends GoRouteData {
  const FilterResultRoute(this.$extra);

  static const route = TypedGoRoute<FilterResultRoute>(
    path: 'filterResult',
    name: 'Filter Result',
  );

  final FilterSelected $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => FilterResultView(
        filter: $extra,
      );
}

final class PlaceRequestFormRoute extends GoRouteData {
  const PlaceRequestFormRoute();

  static const route = TypedGoRoute<PlaceRequestFormRoute>(
    path: 'placeRequestForm',
    name: 'Place Request Form',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PlaceRequestForm();
}

final class ProjectRequestFormRoute extends GoRouteData {
  const ProjectRequestFormRoute();

  static const route = TypedGoRoute<ProjectRequestFormRoute>(
    path: 'projectRequestForm',
    name: 'Project Request Form',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProjectRequestForm();
}

final class ScholarShipRequestFormRoute extends GoRouteData {
  const ScholarShipRequestFormRoute();

  static const route = TypedGoRoute<ScholarShipRequestFormRoute>(
    path: 'scholarShipRequestForm',
    name: 'ScholarShip Request Form',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ScholarshipRequestForm();
}

final class NotificationsRoute extends GoRouteData {
  const NotificationsRoute();

  static const route = TypedGoRoute<NotificationsRoute>(
    path: 'notifications',
    name: 'Notifications',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationsView();
}

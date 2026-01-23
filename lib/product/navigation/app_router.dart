import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/chain_store/view/chain_store_view.dart';
import 'package:lifeclient/features/details/view/event_detail_view.dart';
import 'package:lifeclient/features/details/view/news_detail_view.dart';
import 'package:lifeclient/features/details/view/place_detail_view.dart';
import 'package:lifeclient/features/main/event/view/event_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/news_jobs_view.dart';
import 'package:lifeclient/features/main/settings/view/settings_view.dart';
import 'package:lifeclient/features/splash/splash_view.dart';
import 'package:lifeclient/features/sub_feature/developers/view/developers_view.dart';
import 'package:lifeclient/features/sub_feature/favorite/view/favorite_view.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/model/filter_selected_model.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/filter_result_view.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/filter_search_view.dart';
import 'package:lifeclient/features/sub_feature/forms/index.dart';
import 'package:lifeclient/features/sub_feature/notifications/notifications_view.dart';
import 'package:lifeclient/features/sub_feature/special_agency/view/special_agency_view.dart';
import 'package:lifeclient/features/sub_feature/useful_links/view/useful_links_view.dart';
import 'package:lifeclient/features/tourism/view/tourism_map_view.dart';
import 'package:lifeclient/product/model/news_model_copy.dart';
import 'package:lifeclient/sub_feature/main_tab/main_tab_view.dart';
import 'package:lifeclient/sub_feature/onboard/on_board_view.dart';

export 'package:life_shared/life_shared.dart' show NewsModel;

part 'app_router.g.dart';

@TypedGoRoute<SplashRoute>(
  path: '/',
  routes: [
    OnboardRoute.route,
  ],
)
final class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashView();
}

@TypedGoRoute<MainTabRoute>(
  path: '/main',
  routes: [
    ChainStoresRoute.route,
    TurismRoute.route,
    UsefulLinksRoute.route,
    FavoriteRoute.route,
    SpecialAgencyRoute.route,
    PlaceDetailRoute.route,
    NewsJobsRoute.route,
    FilterRoute.route,
    EventRoute.route,
    NotificationsRoute.route,
    FilterResultRoute.route,

    // Forms
    PlaceRequestFormRoute.route,
    ProjectRequestFormRoute.route,
    ScholarShipRequestFormRoute.route,

    // Settings
    SettingsRoute.route,
  ],
)
final class MainTabRoute extends GoRouteData with $MainTabRoute {
  const MainTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MainTabView();
}

/// You can use this route for home and favorite place cards
final class PlaceDetailRoute extends GoRouteData with $PlaceDetailRoute {
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

final class FilterRoute extends GoRouteData with $FilterRoute {
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

final class FilterResultRoute extends GoRouteData with $FilterResultRoute {
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

final class PlaceRequestFormRoute extends GoRouteData
    with $PlaceRequestFormRoute {
  const PlaceRequestFormRoute();

  static const route = TypedGoRoute<PlaceRequestFormRoute>(
    path: 'placeRequestForm',
    name: 'Place Request Form',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PlaceRequestForm();
}

final class ProjectRequestFormRoute extends GoRouteData
    with $ProjectRequestFormRoute {
  const ProjectRequestFormRoute();

  static const route = TypedGoRoute<ProjectRequestFormRoute>(
    path: 'projectRequestForm',
    name: 'Project Request Form',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProjectRequestForm();
}

final class ScholarShipRequestFormRoute extends GoRouteData
    with $ScholarShipRequestFormRoute {
  const ScholarShipRequestFormRoute();

  static const route = TypedGoRoute<ScholarShipRequestFormRoute>(
    path: 'scholarShipRequestForm',
    name: 'ScholarShip Request Form',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ScholarshipRequestForm();
}

final class NotificationsRoute extends GoRouteData with $NotificationsRoute {
  const NotificationsRoute();

  static const route = TypedGoRoute<NotificationsRoute>(
    path: 'notifications',
    name: 'Notifications',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationsView();
}

final class SpecialAgencyRoute extends GoRouteData with $SpecialAgencyRoute {
  const SpecialAgencyRoute();

  static const route = TypedGoRoute<SpecialAgencyRoute>(
    path: 'specialAgency',
    name: 'Special Agency',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SpecialAgencyView();
}

final class ChainStoresRoute extends GoRouteData with $ChainStoresRoute {
  const ChainStoresRoute();

  static const route = TypedGoRoute<ChainStoresRoute>(
    path: 'chain_stores',
    name: 'Chain Stores',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChainStoreView();
}

final class TurismRoute extends GoRouteData with $TurismRoute {
  const TurismRoute();

  static const route = TypedGoRoute<TurismRoute>(
    path: 'turism',
    name: 'Turism items',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TourismMapView();
}

final class EventRoute extends GoRouteData with $EventRoute {
  const EventRoute();

  static const route = TypedGoRoute<EventRoute>(
    path: 'event',
    name: 'Events',
    routes: [
      EventDetailsRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) => const EventView();
}

final class EventDetailsRoute extends GoRouteData with $EventDetailsRoute {
  EventDetailsRoute({required this.$extra});

  static const route = TypedGoRoute<EventDetailsRoute>(
    path: 'details',
    name: 'Event Details',
  );

  final CampaignModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EventDetailView(event: $extra);
}

final class FavoriteRoute extends GoRouteData with $FavoriteRoute {
  const FavoriteRoute();

  static const route = TypedGoRoute<FavoriteRoute>(
    path: 'favorite',
    name: 'Favorite',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FavoriteView();
}

final class NewsJobsRoute extends GoRouteData with $NewsJobsRoute {
  const NewsJobsRoute();
  static const route = TypedGoRoute<NewsJobsRoute>(
    path: 'newsJobs',
    name: 'News and Jobs',
    routes: [
      NewsDetailRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NewsEventJobsView();
}

final class NewsDetailRoute extends GoRouteData with $NewsDetailRoute {
  NewsDetailRoute({required this.$extra});

  static const route = TypedGoRoute<NewsDetailRoute>(
    path: 'detail',
    name: 'News Details',
  );

  final NewsModelCopy $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      NewsDetailView(news: $extra.toNewsModel());
}

final class OnboardRoute extends GoRouteData with $OnboardRoute {
  const OnboardRoute();

  static const route = TypedGoRoute<OnboardRoute>(
    path: 'onboard',
    name: 'Onboard',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) => const OnBoarView();
}

final class SettingsRoute extends GoRouteData with $SettingsRoute {
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
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsView();
}

final class DevelopersRoute extends GoRouteData with $DevelopersRoute {
  const DevelopersRoute();

  static const route = TypedGoRoute<DevelopersRoute>(
    path: 'developers',
    name: 'Developers',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DevelopersView();
}

final class ApplicationInformationRoute extends GoRouteData
    with $ApplicationInformationRoute {
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

final class UsefulLinksRoute extends GoRouteData with $UsefulLinksRoute {
  const UsefulLinksRoute();

  static const route = TypedGoRoute<UsefulLinksRoute>(
    path: 'useful_links',
    name: 'Useful Links',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UsefulLinksView();
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$splashRoute, $mainTabRoute];

RouteBase get $splashRoute => GoRouteData.$route(
  path: '/',
  factory: $SplashRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'onboard',
      name: 'Onboard',
      factory: $OnboardRoute._fromState,
    ),
  ],
);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OnboardRoute on GoRouteData {
  static OnboardRoute _fromState(GoRouterState state) => const OnboardRoute();

  @override
  String get location => GoRouteData.$location('/onboard');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainTabRoute => GoRouteData.$route(
  path: '/main',
  factory: $MainTabRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'chain_stores',
      name: 'Chain Stores',
      factory: $ChainStoresRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'turism',
      name: 'Turism items',
      factory: $TurismRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'useful_links',
      name: 'Useful Links',
      factory: $UsefulLinksRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'favorite',
      name: 'Favorite',
      factory: $FavoriteRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'specialAgency',
      name: 'Special Agency',
      factory: $SpecialAgencyRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'placeDetail/:id',
      name: 'Place Detail',
      factory: $PlaceDetailRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'newsJobs',
      name: 'News and Jobs',
      factory: $NewsJobsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'detail',
          name: 'News Details',
          factory: $NewsDetailRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'filter',
      name: 'Filter',
      factory: $FilterRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'event',
      name: 'Events',
      factory: $EventRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'details',
          name: 'Event Details',
          factory: $EventDetailsRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'notifications',
      name: 'Notifications',
      factory: $NotificationsRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'filterResult',
      name: 'Filter Result',
      factory: $FilterResultRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'placeRequestForm',
      name: 'Place Request Form',
      factory: $PlaceRequestFormRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'projectRequestForm',
      name: 'Project Request Form',
      factory: $ProjectRequestFormRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'scholarShipRequestForm',
      name: 'ScholarShip Request Form',
      factory: $ScholarShipRequestFormRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'settings',
      name: 'Settings',
      factory: $SettingsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'developers',
          name: 'Developers',
          factory: $DevelopersRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'appInfo',
          name: 'Application Information',
          factory: $ApplicationInformationRoute._fromState,
        ),
      ],
    ),
  ],
);

mixin $MainTabRoute on GoRouteData {
  static MainTabRoute _fromState(GoRouterState state) => const MainTabRoute();

  @override
  String get location => GoRouteData.$location('/main');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChainStoresRoute on GoRouteData {
  static ChainStoresRoute _fromState(GoRouterState state) =>
      const ChainStoresRoute();

  @override
  String get location => GoRouteData.$location('/main/chain_stores');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TurismRoute on GoRouteData {
  static TurismRoute _fromState(GoRouterState state) => const TurismRoute();

  @override
  String get location => GoRouteData.$location('/main/turism');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UsefulLinksRoute on GoRouteData {
  static UsefulLinksRoute _fromState(GoRouterState state) =>
      const UsefulLinksRoute();

  @override
  String get location => GoRouteData.$location('/main/useful_links');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FavoriteRoute on GoRouteData {
  static FavoriteRoute _fromState(GoRouterState state) => const FavoriteRoute();

  @override
  String get location => GoRouteData.$location('/main/favorite');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SpecialAgencyRoute on GoRouteData {
  static SpecialAgencyRoute _fromState(GoRouterState state) =>
      const SpecialAgencyRoute();

  @override
  String get location => GoRouteData.$location('/main/specialAgency');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PlaceDetailRoute on GoRouteData {
  static PlaceDetailRoute _fromState(GoRouterState state) => PlaceDetailRoute(
    id: state.pathParameters['id']!,
    $extra: state.extra as StoreModel,
  );

  PlaceDetailRoute get _self => this as PlaceDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/main/placeDetail/${Uri.encodeComponent(_self.id)}',
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $NewsJobsRoute on GoRouteData {
  static NewsJobsRoute _fromState(GoRouterState state) => const NewsJobsRoute();

  @override
  String get location => GoRouteData.$location('/main/newsJobs');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NewsDetailRoute on GoRouteData {
  static NewsDetailRoute _fromState(GoRouterState state) =>
      NewsDetailRoute($extra: state.extra as NewsModelCopy);

  NewsDetailRoute get _self => this as NewsDetailRoute;

  @override
  String get location => GoRouteData.$location('/main/newsJobs/detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $FilterRoute on GoRouteData {
  static FilterRoute _fromState(GoRouterState state) =>
      FilterRoute($extra: state.extra as String?);

  FilterRoute get _self => this as FilterRoute;

  @override
  String get location => GoRouteData.$location('/main/filter');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $EventRoute on GoRouteData {
  static EventRoute _fromState(GoRouterState state) => const EventRoute();

  @override
  String get location => GoRouteData.$location('/main/event');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EventDetailsRoute on GoRouteData {
  static EventDetailsRoute _fromState(GoRouterState state) =>
      EventDetailsRoute($extra: state.extra as CampaignModel);

  EventDetailsRoute get _self => this as EventDetailsRoute;

  @override
  String get location => GoRouteData.$location('/main/event/details');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $NotificationsRoute on GoRouteData {
  static NotificationsRoute _fromState(GoRouterState state) =>
      const NotificationsRoute();

  @override
  String get location => GoRouteData.$location('/main/notifications');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FilterResultRoute on GoRouteData {
  static FilterResultRoute _fromState(GoRouterState state) =>
      FilterResultRoute(state.extra as FilterSelected);

  FilterResultRoute get _self => this as FilterResultRoute;

  @override
  String get location => GoRouteData.$location('/main/filterResult');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $PlaceRequestFormRoute on GoRouteData {
  static PlaceRequestFormRoute _fromState(GoRouterState state) =>
      const PlaceRequestFormRoute();

  @override
  String get location => GoRouteData.$location('/main/placeRequestForm');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProjectRequestFormRoute on GoRouteData {
  static ProjectRequestFormRoute _fromState(GoRouterState state) =>
      const ProjectRequestFormRoute();

  @override
  String get location => GoRouteData.$location('/main/projectRequestForm');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ScholarShipRequestFormRoute on GoRouteData {
  static ScholarShipRequestFormRoute _fromState(GoRouterState state) =>
      const ScholarShipRequestFormRoute();

  @override
  String get location => GoRouteData.$location('/main/scholarShipRequestForm');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/main/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DevelopersRoute on GoRouteData {
  static DevelopersRoute _fromState(GoRouterState state) =>
      const DevelopersRoute();

  @override
  String get location => GoRouteData.$location('/main/settings/developers');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ApplicationInformationRoute on GoRouteData {
  static ApplicationInformationRoute _fromState(GoRouterState state) =>
      const ApplicationInformationRoute();

  @override
  String get location => GoRouteData.$location('/main/settings/appInfo');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

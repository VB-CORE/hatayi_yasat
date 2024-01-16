// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $mainTabRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      factory: $SplashRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'onboard',
          name: 'Onboard',
          factory: $OnboardRouteExtension._fromState,
        ),
      ],
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OnboardRouteExtension on OnboardRoute {
  static OnboardRoute _fromState(GoRouterState state) => const OnboardRoute();

  String get location => GoRouteData.$location(
        '/onboard',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainTabRoute => GoRouteData.$route(
      path: '/main',
      factory: $MainTabRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'favorite',
          name: 'Favorite',
          factory: $FavoriteRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'specialAgency',
          name: 'Special Agency',
          factory: $SpecialAgencyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'placeDetail/:id',
          name: 'Place Detail',
          factory: $PlaceDetailRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'developers',
          name: 'Developers',
          factory: $DevelopersRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'newsJobs',
          name: 'News and Jobs',
          factory: $NewsJobsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'detail',
              name: 'News Details',
              factory: $NewsDetailRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'filter',
          name: 'Filter',
          factory: $FilterRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'event',
          name: 'Events',
          factory: $EventRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'details',
              name: 'Event Details',
              factory: $EventDetailsRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'filterResult',
          name: 'Filter Result',
          factory: $FilterResultRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'placeRequestForm',
          name: 'Place Request Form',
          factory: $PlaceRequestFormRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'projectRequestForm',
          name: 'Project Request Form',
          factory: $ProjectRequestFormRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'scholarShipRequestForm',
          name: 'ScholarShip Request Form',
          factory: $ScholarShipRequestFormRouteExtension._fromState,
        ),
      ],
    );

extension $MainTabRouteExtension on MainTabRoute {
  static MainTabRoute _fromState(GoRouterState state) => const MainTabRoute();

  String get location => GoRouteData.$location(
        '/main',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FavoriteRouteExtension on FavoriteRoute {
  static FavoriteRoute _fromState(GoRouterState state) => const FavoriteRoute();

  String get location => GoRouteData.$location(
        '/main/favorite',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SpecialAgencyRouteExtension on SpecialAgencyRoute {
  static SpecialAgencyRoute _fromState(GoRouterState state) =>
      const SpecialAgencyRoute();

  String get location => GoRouteData.$location(
        '/main/specialAgency',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PlaceDetailRouteExtension on PlaceDetailRoute {
  static PlaceDetailRoute _fromState(GoRouterState state) => PlaceDetailRoute(
        id: state.pathParameters['id']!,
        $extra: state.extra as StoreModel,
      );

  String get location => GoRouteData.$location(
        '/main/placeDetail/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $DevelopersRouteExtension on DevelopersRoute {
  static DevelopersRoute _fromState(GoRouterState state) =>
      const DevelopersRoute();

  String get location => GoRouteData.$location(
        '/main/developers',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewsJobsRouteExtension on NewsJobsRoute {
  static NewsJobsRoute _fromState(GoRouterState state) => const NewsJobsRoute();

  String get location => GoRouteData.$location(
        '/main/newsJobs',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewsDetailRouteExtension on NewsDetailRoute {
  static NewsDetailRoute _fromState(GoRouterState state) => NewsDetailRoute(
        $extra: state.extra as NewsModel,
      );

  String get location => GoRouteData.$location(
        '/main/newsJobs/detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $FilterRouteExtension on FilterRoute {
  static FilterRoute _fromState(GoRouterState state) => FilterRoute(
        $extra: state.extra as String?,
      );

  String get location => GoRouteData.$location(
        '/main/filter',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $EventRouteExtension on EventRoute {
  static EventRoute _fromState(GoRouterState state) => const EventRoute();

  String get location => GoRouteData.$location(
        '/main/event',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EventDetailsRouteExtension on EventDetailsRoute {
  static EventDetailsRoute _fromState(GoRouterState state) => EventDetailsRoute(
        $extra: state.extra as CampaignModel,
      );

  String get location => GoRouteData.$location(
        '/main/event/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $FilterResultRouteExtension on FilterResultRoute {
  static FilterResultRoute _fromState(GoRouterState state) => FilterResultRoute(
        state.extra as FilterSelected,
      );

  String get location => GoRouteData.$location(
        '/main/filterResult',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $PlaceRequestFormRouteExtension on PlaceRequestFormRoute {
  static PlaceRequestFormRoute _fromState(GoRouterState state) =>
      const PlaceRequestFormRoute();

  String get location => GoRouteData.$location(
        '/main/placeRequestForm',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProjectRequestFormRouteExtension on ProjectRequestFormRoute {
  static ProjectRequestFormRoute _fromState(GoRouterState state) =>
      const ProjectRequestFormRoute();

  String get location => GoRouteData.$location(
        '/main/projectRequestForm',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ScholarShipRequestFormRouteExtension on ScholarShipRequestFormRoute {
  static ScholarShipRequestFormRoute _fromState(GoRouterState state) =>
      const ScholarShipRequestFormRoute();

  String get location => GoRouteData.$location(
        '/main/scholarShipRequestForm',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

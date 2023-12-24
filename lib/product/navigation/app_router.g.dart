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
          path: 'placeDetail',
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
        $extra: state.extra as StoreModel,
      );

  String get location => GoRouteData.$location(
        '/main/placeDetail',
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
  static FilterRoute _fromState(GoRouterState state) => const FilterRoute();

  String get location => GoRouteData.$location(
        '/main/filter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

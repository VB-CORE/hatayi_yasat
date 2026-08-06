import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/auth/view/login_view.dart';
import 'package:lifeclient/features/chain_store/view/chain_store_view.dart';
import 'package:lifeclient/features/community/create_group/view/create_group_view.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/discussion_detail/view/discussion_detail_view.dart';
import 'package:lifeclient/features/community/group_detail/group_detail_view.dart';
import 'package:lifeclient/features/details/view/event_detail_view.dart';
import 'package:lifeclient/features/details/view/news_detail_view.dart';
import 'package:lifeclient/features/main/event/view/event_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/news_jobs_view.dart';
import 'package:lifeclient/features/main/profile/view/edit/edit_profile_view.dart';
import 'package:lifeclient/features/main/settings/view/settings_view.dart';
import 'package:lifeclient/features/merchant_panel/view/merchant_panel_view.dart';
import 'package:lifeclient/features/monetization/form/monetization_coupon_form_view.dart';
import 'package:lifeclient/features/monetization/redeem/coupon_redeem_view.dart';
import 'package:lifeclient/features/monetization/view/monetization_view.dart';
import 'package:lifeclient/features/onboarding/view/onboarding_view.dart';
import 'package:lifeclient/features/place_detail/view/place_detail_view.dart';
import 'package:lifeclient/features/splash/splash_view.dart';
import 'package:lifeclient/features/sub_feature/developers/view/developers_contributors_view.dart';
import 'package:lifeclient/features/sub_feature/developers/view/developers_view.dart';
import 'package:lifeclient/features/sub_feature/favorite/view/favorite_view.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/model/filter_selected_model.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/filter_result_view.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/filter_search_view.dart';
import 'package:lifeclient/features/sub_feature/forms/index.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/view/merchant_application_status_pending_view.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/view/merchant_application_view.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/notifications_view.dart';
import 'package:lifeclient/features/sub_feature/saved_news/view/saved_news_view.dart';
import 'package:lifeclient/features/sub_feature/special_agency/view/special_agency_view.dart';
import 'package:lifeclient/features/sub_feature/useful_links/view/useful_links_view.dart';
import 'package:lifeclient/features/sub_feature/user_qr/view/user_qr_view.dart';
import 'package:lifeclient/features/tourism/view/tourism_map_view.dart';
import 'package:lifeclient/product/navigation/auth_guard.dart';
import 'package:lifeclient/sub_feature/banned/banned_view.dart';
import 'package:lifeclient/sub_feature/main_tab/main_tab_view.dart';
import 'package:lifeclient/sub_feature/unauthorized/unauthorized_view.dart';

export 'package:life_shared/life_shared.dart' show NewsModel;

part 'app_router.g.dart';
part 'merchant_guard.dart';

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
    MonetizationRoute.route,
    TurismRoute.route,
    UsefulLinksRoute.route,
    FavoriteRoute.route,
    SavedNewsRoute.route,
    SpecialAgencyRoute.route,
    PlaceDetailRoute.route,
    NewsJobsRoute.route,
    FilterRoute.route,
    EventRoute.route,
    NotificationsRoute.route,
    FilterResultRoute.route,
    UserQrRoute.route,

    // Forms
    PlaceRequestFormRoute.route,
    _MerchantPanelRoute.route,
    _MerchantPendingRoute.route,
    _MerchantApplicationRoute.route,
    ProjectRequestFormRoute.route,
    ScholarShipRequestFormRoute.route,

    // Settings
    SettingsRoute.route,
    EditProfileRoute.route,

    // Community
    CreateGroupRoute.route,
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
    store: $extra,
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
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requireLogin(context, state);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PlaceRequestForm();
}

final class _MerchantPanelRoute extends GoRouteData with $_MerchantPanelRoute {
  const _MerchantPanelRoute();

  static const route = TypedGoRoute<_MerchantPanelRoute>(
    path: 'merchantPanel',
    name: 'Merchant Panel',
  );

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      MerchantGuard.redirect(context, state);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MerchantPanelView();
}

final class _MerchantApplicationRoute extends GoRouteData
    with $_MerchantApplicationRoute {
  const _MerchantApplicationRoute();

  static const route = TypedGoRoute<_MerchantApplicationRoute>(
    path: 'merchantApplication',
    name: 'Merchant Application',
  );

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      MerchantGuard.redirect(context, state);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MerchantApplicationView();
}

final class _MerchantPendingRoute extends GoRouteData
    with $_MerchantPendingRoute {
  const _MerchantPendingRoute();

  static const route = TypedGoRoute<_MerchantPendingRoute>(
    path: 'merchantPending',
    name: 'Merchant Pending',
  );

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      MerchantGuard.redirect(context, state);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final application = AuthGuard.application(context)!;
    return MerchantApplicationPendingView(application);
  }
}

final class ProjectRequestFormRoute extends GoRouteData
    with $ProjectRequestFormRoute {
  const ProjectRequestFormRoute();

  static const route = TypedGoRoute<ProjectRequestFormRoute>(
    path: 'projectRequestForm',
    name: 'Project Request Form',
  );

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requireLogin(context, state);

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
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requireLogin(context, state);

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

final class UserQrRoute extends GoRouteData with $UserQrRoute {
  const UserQrRoute();

  static const route = TypedGoRoute<UserQrRoute>(
    path: 'userQr',
    name: 'User QR',
  );

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requireLogin(context, state);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: build(context, state),
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) => const UserQrView();
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

final class MonetizationRoute extends GoRouteData with $MonetizationRoute {
  const MonetizationRoute();

  static const route = TypedGoRoute<MonetizationRoute>(
    path: 'monetization',
    name: 'Monetization',
    routes: [
      MonetizationCouponFormRoute.route,
      CouponRedeemRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MonetizationView();
}

final class CouponRedeemRoute extends GoRouteData with $CouponRedeemRoute {
  const CouponRedeemRoute({required this.$extra});

  static const route = TypedGoRoute<CouponRedeemRoute>(
    path: 'redeem',
    name: 'Coupon Redeem',
  );

  final CouponModel $extra;

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requireLogin(context, state);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CouponRedeemView(coupon: $extra);
}

final class MonetizationCouponFormRoute extends GoRouteData
    with $MonetizationCouponFormRoute {
  const MonetizationCouponFormRoute({this.$extra});

  static const route = TypedGoRoute<MonetizationCouponFormRoute>(
    path: 'couponForm',
    name: 'Monetization Coupon Form',
  );

  final CouponModel? $extra;

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requireLogin(context, state);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: build(context, state),
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      MonetizationCouponFormView(coupon: $extra);
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

final class SavedNewsRoute extends GoRouteData with $SavedNewsRoute {
  const SavedNewsRoute();

  static const route = TypedGoRoute<SavedNewsRoute>(
    path: 'savedNews',
    name: 'Saved News',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SavedNewsView();
}

final class NewsJobsRoute extends GoRouteData with $NewsJobsRoute {
  const NewsJobsRoute();
  static const route = TypedGoRoute<NewsJobsRoute>(
    path: 'news',
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
  NewsDetailRoute({required this.$extra, required this.id});

  static const route = TypedGoRoute<NewsDetailRoute>(
    path: ':id',
    name: 'News Details',
  );

  final NewsModel $extra;
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      NewsDetailView(news: $extra);
}

@TypedGoRoute<LoginRoute>(path: '/login')
final class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute({this.from});

  final String? from;

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.redirectIfSignedIn(context, state, to: from);

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginView();
}

@TypedGoRoute<BannedRoute>(path: '/banned')
final class BannedRoute extends GoRouteData with $BannedRoute {
  const BannedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BannedView();
}

@TypedGoRoute<UnauthorizedRoute>(path: '/unauthorized')
final class UnauthorizedRoute extends GoRouteData with $UnauthorizedRoute {
  const UnauthorizedRoute({this.attemptedPath});

  final String? attemptedPath;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      UnauthorizedView(attemptedPath: attemptedPath);
}

final class CreateGroupRoute extends GoRouteData with $CreateGroupRoute {
  const CreateGroupRoute();

  static const route = TypedGoRoute<CreateGroupRoute>(path: 'create-group');

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requirePermission(
        context,
        state,
        hasPermission: (user) => user.canCreateGroup,
      );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateGroupView();
}

@TypedGoRoute<GroupDetailRoute>(path: '/group-detail')
final class GroupDetailRoute extends GoRouteData with $GroupDetailRoute {
  GroupDetailRoute({required this.$extra});

  final GroupModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GroupDetailView(model: $extra);
}

@TypedGoRoute<DiscussionDetailRoute>(path: '/discussion-detail')
final class DiscussionDetailRoute extends GoRouteData
    with $DiscussionDetailRoute {
  DiscussionDetailRoute({required this.$extra});

  final DiscussionDetailArgs $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DiscussionDetailView(args: $extra);
}

final class OnboardRoute extends GoRouteData with $OnboardRoute {
  const OnboardRoute();

  static const route = TypedGoRoute<OnboardRoute>(
    path: 'onboard',
    name: 'Onboard',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingView();
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

final class EditProfileRoute extends GoRouteData with $EditProfileRoute {
  const EditProfileRoute();

  static const route = TypedGoRoute<EditProfileRoute>(
    path: 'editProfile',
    name: 'Edit Profile',
  );

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      AuthGuard.requireLogin(context, state);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: build(context, state),
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EditProfileView();
}

final class DevelopersRoute extends GoRouteData with $DevelopersRoute {
  const DevelopersRoute();

  static const route = TypedGoRoute<DevelopersRoute>(
    path: 'developers',
    name: 'Developers',
    routes: [
      DevelopersContributorsRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DevelopersView();
}

final class DevelopersContributorsRoute extends GoRouteData
    with $DevelopersContributorsRoute {
  const DevelopersContributorsRoute();

  static const route = TypedGoRoute<DevelopersContributorsRoute>(
    path: 'contributors',
    name: 'Developers Contributors',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DevelopersContributorsView();
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

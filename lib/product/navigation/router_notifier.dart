import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

// GoRouter's refreshListenable requires a ChangeNotifier; ChangeNotifierProvider
// was removed in flutter_riverpod v3, so this is exposed via a plain Provider
// instead of following the Equatable+copyWith state pattern.
final class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authViewModelProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authViewModelProvider);
    final isLoginRoute = state.matchedLocation == const LoginRoute().location;

    if (authState is Authenticated && isLoginRoute) {
      final role = authState.user.role;
      if (kDebugMode && role != UserRole.user) {
        return RoleDashboardRoute(role: role.name).location;
      }
      return const MainTabRoute().location;
    }
    return null;
  }
}

final Provider<RouterNotifier> routerNotifierProvider =
    Provider<RouterNotifier>(RouterNotifier.new);

final Provider<GoRouter> goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);
  return GoRouter(
    routes: $appRoutes,
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    observers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
  );
});

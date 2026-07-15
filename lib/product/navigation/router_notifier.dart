import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

// GoRouter'ın refreshListenable'ı ChangeNotifier gerektiriyor; ChangeNotifierProvider
// flutter_riverpod v3'te kaldırıldığı için bu, Equatable+copyWith state pattern'i
// yerine düz bir Provider üzerinden dışa açılıyor.
final class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authViewModelProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authViewModelProvider);
    final location = state.matchedLocation;
    final isLoginRoute = location == const LoginRoute().location;

    final isMerchantApplicationRoute =
        location == const MerchantApplicationViewRoute().location ||
        location == const MerchantApplicationStatusRoute().location;
    if (isMerchantApplicationRoute && authState is! Authenticated) {
      return const LoginRoute().location;
    }

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

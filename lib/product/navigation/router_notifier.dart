import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

/// GoRouter'ın refreshListenable'ı ChangeNotifier ister; ChangeNotifierProvider
/// flutter_riverpod v3'te kaldırıldığı için auth değişimini notifyListeners'a
/// köprüleyen ince bir bridge'dir. Yönlendirme kararları rotaların kendi
/// redirect'lerinde (bkz. AuthGuard) verilir — burada karar yoktur.
///
/// Yalnızca auth status / permission / role değişiminde refresh eder
final class RouterNotifier extends ChangeNotifier {
  RouterNotifier(Ref ref) {
    ref.listen(authViewModelProvider, (previous, next) {
      if (!_shouldRefreshRouter(previous, next)) return;
      notifyListeners();
    });
  }

  static bool _shouldRefreshRouter(AuthState? previous, AuthState next) {
    if (previous == null) return true;

    if (previous.runtimeType != next.runtimeType) return true;

    final previousUser = previous.user;
    final nextUser = next.user;
    
    if (previousUser == null && nextUser == null) return false;
    if (previousUser == null || nextUser == null) return true;
    return previousUser.roleType != nextUser.roleType ||
        !listEquals(previousUser.permissions, nextUser.permissions);
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
    observers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
  );
});

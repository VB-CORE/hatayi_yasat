import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

/// GoRouter'ın refreshListenable'ı ChangeNotifier ister; ChangeNotifierProvider
/// flutter_riverpod v3'te kaldırıldığı için auth değişimini notifyListeners'a
/// köprüleyen ince bir bridge'dir. Yönlendirme kararları rotaların kendi
/// redirect'lerinde (bkz. AuthGuard) verilir — burada karar yoktur.
final class RouterNotifier extends ChangeNotifier {
  RouterNotifier(Ref ref) {
    ref.listen(authViewModelProvider, (_, _) => notifyListeners());
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

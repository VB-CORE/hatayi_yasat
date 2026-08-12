part of 'app_router.dart';

abstract final class MerchantGuard {
  const MerchantGuard._();

  static String? redirect(BuildContext context, GoRouterState state) {
    final loginRedirect = AuthGuard.requireLogin(context, state);
    if (loginRedirect != null) return loginRedirect;

    final target = location(context);
    return state.matchedLocation == target ? null : target;
  }

  static void go(BuildContext context) => context.go(location(context));

  static void pushReplacement(BuildContext context) =>
      context.pushReplacement(location(context));

  static String location(BuildContext context) =>
      switch (AuthGuard.application(context)?.status) {
        .approved => const _MerchantPanelRoute().location,
        .pending => const _MerchantPendingRoute().location,
        _ => const _MerchantApplicationRoute().location,
      };
}

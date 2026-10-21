import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ModalRouteTracker> modalRouteTrackerProvider =
    Provider<ModalRouteTracker>((ref) {
      final tracker = ModalRouteTracker();
      ref.onDispose(tracker.dispose);
      return tracker;
    });

final class ModalRouteTracker extends NavigatorObserver {
  final ValueNotifier<bool> isModalOpen = ValueNotifier<bool>(false);
  final List<PopupRoute<dynamic>> _openRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PopupRoute) _changeRoutes(() => _openRoutes.add(route));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PopupRoute) _changeRoutes(() => _openRoutes.remove(route));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PopupRoute) _changeRoutes(() => _openRoutes.remove(route));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _changeRoutes(() {
      if (oldRoute is PopupRoute) _openRoutes.remove(oldRoute);
      if (newRoute is PopupRoute) _openRoutes.add(newRoute);
    });
  }

  void dismissTopRoute() {
    if (_openRoutes.isEmpty) return;
    final route = _openRoutes.last;
    if (!route.barrierDismissible || !route.isCurrent) return;
    unawaited(route.navigator?.maybePop());
  }

  void dispose() => isModalOpen.dispose();

  void _changeRoutes(VoidCallback change) {
    change();
    final scheduler = SchedulerBinding.instance;
    if (scheduler.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      scheduler.addPostFrameCallback((_) => _publish());
      return;
    }
    _publish();
  }

  void _publish() => isModalOpen.value = _openRoutes.isNotEmpty;
}

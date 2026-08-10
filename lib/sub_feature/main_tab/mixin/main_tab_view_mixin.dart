import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_view_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/sub_feature/main_tab/main_tab_view.dart';
import 'package:lifeclient/sub_feature/main_tab/model/main_tab.dart';
import 'package:lifeclient/sub_feature/main_tab/model/tab_model.dart';
import 'package:lifeclient/sub_feature/main_tab/view_model/main_tab_view_model.dart';

mixin MainTabViewMixin
    on
        AppProviderMixin<MainTabView>,
        SingleTickerProviderStateMixin<MainTabView>,
        ConsumerState<MainTabView>,
        WidgetsBindingObserver {
  static const double _hideScrollDeltaThreshold = 6;

  late final List<TabModel> tabItems;
  late final TabController tabController;

  int _reportedTabIndex = -1;

  @override
  void initState() {
    super.initState();
    tabItems = TabModels.create().tabItems;
    tabController = TabController(
      length: tabItems.length,
      initialIndex: widget.tab?.index ?? MainTab.places.index,
      vsync: this,
    )..addListener(_reportCurrentTab);
    _reportCurrentTab();
    _clearTabQuery();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      // Riverpod refuses provider writes from initState; the first badge read
      // has to wait until the frame that mounted this widget is done.
      unawaited(ref.read(notificationBadgeViewModelProvider.notifier).refresh());
    });
  }

  @override
  void didUpdateWidget(covariant MainTabView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final tab = widget.tab;
    if (tab == null) return;
    tabController.animateTo(tab.index);
    _clearTabQuery();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    tabController
      ..removeListener(_reportCurrentTab)
      ..dispose();
    super.dispose();
  }

  /// The badge is a server-pushed number while the app sleeps; coming back to
  /// the foreground is the first chance to replace it with the real one.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    unawaited(ref.read(notificationBadgeViewModelProvider.notifier).refresh());
  }

  /// The tabs are not routes, so the router observer never reports them; each
  /// one is sent by hand instead. The listener fires repeatedly while the
  /// indicator animates, hence the index guard.
  void _reportCurrentTab() {
    final index = tabController.index;
    if (index == _reportedTabIndex) return;
    _reportedTabIndex = index;
    analyticsService.logScreenView(tabItems[index].analyticsName);
  }

  void listenScrollUpdateNotification(ScrollUpdateNotification notification) {
    if (notification.dragDetails == null) return;

    final delta = notification.scrollDelta;
    if (delta == null || delta == 0) return;

    final notifier = ref.read(mainTabViewModelProvider.notifier);
    if (delta > _hideScrollDeltaThreshold &&
        notification.metrics.pixels > context.sized.dynamicHeight(.05)) {
      notifier.updateBottomBarValue(isScrolledBottom: true);
    } else if (delta < 0) {
      notifier.updateBottomBarValue(isScrolledBottom: false);
    }
  }

  void _clearTabQuery() {
    if (widget.tab == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) const MainTabRoute().go(context);
    });
  }
}

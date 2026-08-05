import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/sub_feature/whats_new/whats_new_sheet_manager.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/sub_feature/main_tab/main_tab_view.dart';
import 'package:lifeclient/sub_feature/main_tab/model/tab_model.dart';
import 'package:lifeclient/sub_feature/main_tab/view_model/main_tab_view_model.dart';

mixin MainTabViewMixin
    on
        AppProviderMixin<MainTabView>,
        SingleTickerProviderStateMixin<MainTabView>,
        ConsumerState<MainTabView> {
  static const double _hideScrollDeltaThreshold = 6;

  late final List<TabModel> tabItems;
  late final TabController tabController;

  int _reportedTabIndex = -1;

  @override
  void initState() {
    super.initState();
    tabItems = TabModels.create().tabItems;
    tabController = TabController(length: tabItems.length, vsync: this)
      ..addListener(_reportCurrentTab);
    _reportCurrentTab();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      WhatsNewSheetManager(context: context).show();
    });
  }

  @override
  void dispose() {
    tabController
      ..removeListener(_reportCurrentTab)
      ..dispose();
    super.dispose();
  }

  /// The tabs are not routes, so the router observer never reports them; each
  /// one is sent by hand instead. The listener fires repeatedly while the
  /// indicator animates, hence the index guard.
  void _reportCurrentTab() {
    final index = tabController.index;
    if (index == _reportedTabIndex) return;
    _reportedTabIndex = index;
    unawaited(analyticsService.logScreenView(tabItems[index].analyticsName));
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
}

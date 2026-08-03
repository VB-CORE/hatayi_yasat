import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/sub_feature/whats_new/whats_new_sheet_manager.dart';
import 'package:lifeclient/product/model/enum/redirect_tabs.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/sub_feature/main_tab/main_tab_view.dart';
import 'package:lifeclient/sub_feature/main_tab/view_model/main_tab_view_model.dart';

mixin MainTabViewMixin
    on
        AppProviderMixin<MainTabView>,
        TickerProviderStateMixin<MainTabView>,
        ConsumerState<MainTabView> {
  late final TabController _controller;
  TabController get controller => _controller;

  static const double _hideScrollDeltaThreshold = 6;

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

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: RedirectTabs.values.length,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WhatsNewSheetManager(context: context).show();
    });
  }
}

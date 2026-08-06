import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/sub_feature/whats_new/whats_new_sheet_manager.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/sub_feature/main_tab/main_tab_view.dart';
import 'package:lifeclient/sub_feature/main_tab/model/main_tab.dart';
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
      length: MainTab.values.length,
      initialIndex: widget.tab?.index ?? MainTab.places.index,
      vsync: this,
    );
    _clearTabQuery();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WhatsNewSheetManager(context: context).show();
    });
  }

  @override
  void didUpdateWidget(covariant MainTabView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final tab = widget.tab;
    if (tab == null) return;
    _controller.animateTo(tab.index);
    _clearTabQuery();
  }

  /// Uygulanan `?tab=` parametresini URL'den silerek istegi tuketir.
  void _clearTabQuery() {
    if (widget.tab == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) const MainTabRoute().go(context);
    });
  }
}

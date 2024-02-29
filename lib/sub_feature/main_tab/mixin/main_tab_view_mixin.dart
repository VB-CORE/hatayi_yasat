import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
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

  void listenScrollUpdateNotification(ScrollUpdateNotification notification) {
    if (notification.metrics.axisDirection == AxisDirection.down) {
      ref.read(mainTabViewModelProvider.notifier).updateBottomBarValue(
            isScrolledBottom:
                notification.metrics.pixels > context.sized.dynamicHeight(.2),
          );
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: RedirectTabs.values.length,
      vsync: this,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/product/model/enum/redirect_tabs.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/sub_feature/tab/main_tab_view.dart';

mixin MainTabViewMixin
    on
        AppProviderMixin<MainTabView>,
        TickerProviderStateMixin<MainTabView>,
        ConsumerState<MainTabView> {
  late final TabController _controller;
  TabController get controller => _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: RedirectTabs.values.length,
      vsync: this,
    );
  }
}

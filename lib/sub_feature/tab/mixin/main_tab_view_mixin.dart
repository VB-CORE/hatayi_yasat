import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/model/enum/firebase_remote_enums.dart';
import 'package:vbaseproject/product/model/enum/redirect_tabs.dart';
import 'package:vbaseproject/product/utility/constants/duration_constant.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/product/widget/dialog/video_dialog.dart';
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

    Future.delayed(
      DurationConstant.durationMedium,
      _controlRepublicDay,
    );
  }

  Future<void> _controlRepublicDay() async {
    if (!FirebaseRemoteEnums.specialDay.valueBool) return;
    if (SharedCache.instance.isRepublicDayShow) return;
    await SharedCache.instance.setRepublicDay();
    if (!mounted) return;
    await VideoDialogRepublic.show(
      context: context,
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/agency_router/agency_router.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/favorite_router/favorite_router.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/product/widget/general/title/general_content_sub_title.dart';
import 'package:vbaseproject/product/widget/general/title/general_sub_title.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial_child.dart';
import 'package:vbaseproject/sub_feature/tab/mixin/main_tab_view_mixin.dart';
import 'package:vbaseproject/sub_feature/tab/model/speed_dial_child_model.dart';
import 'package:vbaseproject/sub_feature/tab/model/tab_model.dart';

part './widget/main_app_bar.dart';
part './widget/main_bottom_app_bar.dart';
part './widget/main_fab_button.dart';

final class MainTabView extends ConsumerStatefulWidget {
  const MainTabView({super.key});

  @override
  ConsumerState<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends ConsumerState<MainTabView>
    with TickerProviderStateMixin, AppProviderMixin, MainTabViewMixin {
  final _tabItems = TabModels.create().tabItems;
  final _speedDialItems = SpeedDialChildModelList().speedDialChildItems;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabItems.length,
      child: Scaffold(
        extendBody: true,
        appBar: _MainAppBar(context: context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _BodyTabBarViewWidget(tabItems: _tabItems),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _BottomAppBarWidget(tabItems: _tabItems),
        floatingActionButton: _SpeedDialFabWidget(dialItems: _speedDialItems),
      ),
    );
  }
}

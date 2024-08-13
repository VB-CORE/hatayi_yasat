import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/agency_router/agency_router.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/chain_stores_router/chain_stores_router.dart';
import 'package:lifeclient/product/navigation/favorite_router/favorite_router.dart';
import 'package:lifeclient/product/navigation/useful_links_router/useful_links_router.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/product/widget/general/title/general_content_sub_title.dart';
import 'package:lifeclient/product/widget/general/title/general_sub_title.dart';
import 'package:lifeclient/product/widget/speed_dial/custom_speed_dial.dart';
import 'package:lifeclient/product/widget/speed_dial/custom_speed_dial_child.dart';
import 'package:lifeclient/sub_feature/main_tab/mixin/main_tab_view_mixin.dart';
import 'package:lifeclient/sub_feature/main_tab/model/speed_dial_child_model.dart';
import 'package:lifeclient/sub_feature/main_tab/model/tab_model.dart';
import 'package:lifeclient/sub_feature/main_tab/view_model/main_tab_view_model.dart';

part 'widget/main_app_bar.dart';
part 'widget/main_bottom_app_bar.dart';
part 'widget/main_fab_button.dart';

final class MainTabView extends ConsumerStatefulWidget {
  const MainTabView({super.key});

  @override
  ConsumerState<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends ConsumerState<MainTabView>
    with TickerProviderStateMixin, AppProviderMixin, MainTabViewMixin {
  final _tabItems = TabModels.create().tabItems;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        listenScrollUpdateNotification(notification);
        return true;
      },
      child: DefaultTabController(
        length: _tabItems.length,
        child: Scaffold(
          extendBody: true,
          appBar: _MainAppBar(context: context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: _BodyTabBarViewWidget(tabItems: _tabItems),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: _BottomAppBarWidget(tabItems: _tabItems),
          floatingActionButton: const _SpeedDialFabWidget(),
        ),
      ),
    );
  }
}

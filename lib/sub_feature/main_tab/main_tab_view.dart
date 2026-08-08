import 'dart:ui' show ImageFilter;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/widget/soft_icon_box.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_view_model.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';
import 'package:lifeclient/product/widget/general/title/general_content_sub_title.dart';
import 'package:lifeclient/product/widget/speed_dial/custom_speed_dial.dart';
import 'package:lifeclient/product/widget/speed_dial/custom_speed_dial_child.dart';
import 'package:lifeclient/sub_feature/main_tab/mixin/main_tab_view_mixin.dart';
import 'package:lifeclient/sub_feature/main_tab/model/main_tab.dart';
import 'package:lifeclient/sub_feature/main_tab/model/speed_dial_child_model.dart';
import 'package:lifeclient/sub_feature/main_tab/model/tab_model.dart';
import 'package:lifeclient/sub_feature/main_tab/view_model/main_tab_view_model.dart';
import 'package:lifeclient/sub_feature/main_tab/widget/qr_fab_button.dart';

part 'widget/discover_menu_overlay.dart';
part 'widget/main_app_bar.dart';
part 'widget/main_bottom_app_bar.dart';
part 'widget/main_fab_button.dart';

final class MainTabView extends ConsumerStatefulWidget {
  const MainTabView({this.tab, super.key});

  final MainTab? tab;

  @override
  ConsumerState<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends ConsumerState<MainTabView>
    with
        SingleTickerProviderStateMixin,
        AppProviderMixin,
        WidgetsBindingObserver,
        MainTabViewMixin {
  double get bottomSafePadding =>
      _BottomAppBarWidget.height + context.general.mediaQuery.padding.bottom;

  @override
  Widget build(BuildContext context) {
    return GeneralSemantic(
      semanticKey: GeneralSemanticKeys.mainTabView,
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          listenScrollUpdateNotification(notification);
          return true;
        },
        child: ListenableBuilder(
          listenable: tabController,
          builder: (context, _) {
            final currentTab = tabItems[tabController.index];
            return Scaffold(
              extendBody: true,
              appBar: currentTab.showAppBar ? _MainAppBar() : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: Stack(
                children: [
                  _BodyTabBarViewWidget(
                    tabItems: tabItems,
                    controller: tabController,
                  ),
                  if (currentTab.showQr) QrFabButton(bottom: bottomSafePadding),
                ],
              ),
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: GeneralSemantic(
                semanticKey: GeneralSemanticKeys.mainTabBottomNavigation,
                child: _BottomAppBarWidget(
                  tabItems: tabItems,
                  controller: tabController,
                ),
              ),
              floatingActionButton: const _SpeedDialFabWidget(),
            );
          },
        ),
      ),
    );
  }
}

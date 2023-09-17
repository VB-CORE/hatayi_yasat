import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/home_module/notifications/notifications_view.dart';
import 'package:vbaseproject/features/request/company/request_company_view.dart';
import 'package:vbaseproject/features/request/project/request_project_view.dart';
import 'package:vbaseproject/features/settings_module/settings/settings_view.dart';
import 'package:vbaseproject/features/tab/model/tab_model.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/items/colors_custom.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';
import 'package:vbaseproject/product/widget/button/appbar_icon_button.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial_child.dart';

class MainTabView extends StatelessWidget {
  MainTabView({super.key});

  final _items = TabModels.create().tabItems;
  final _fabLocation = FloatingActionButtonLocation.centerDocked;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _items.length,
      child: Scaffold(
        extendBody: true,
        appBar: appBarWidget(context),
        body: bodyTabBarView(),
        bottomNavigationBar: bottomAppBarWidget(),
        floatingActionButtonLocation: _fabLocation,
        floatingActionButton: floatingActionButtonWidget(context),
      ),
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      title: const Text(LocaleKeys.project_name).tr(context: context),
      actions: const [
        AppbarIconButton(
          iconData: Icons.notifications_active_outlined,
          destination: NotificationsView(),
        ),
        AppbarIconButton(
          iconData: Icons.settings_outlined,
          destination: SettingsView(),
        ),
      ],
    );
  }

  Widget floatingActionButtonWidget(BuildContext context) {
    return CustomSpeedDial(
      children: [
        CustomSpeedDialChild(
          context: context,
          destination: const RequestCompanyView(),
          label: LocaleKeys.requestCompany_title,
        ),
        CustomSpeedDialChild(
          context: context,
          destination: const RequestProjectView(),
          label: LocaleKeys.projectRequest_title,
        ),
      ],
    );
  }

  BottomAppBar bottomAppBarWidget() {
    return BottomAppBar(
      notchMargin: WidgetSizes.spacingXs,
      shape: const CircularNotchedRectangle(),
      child: TabBar(
        dividerColor: ColorsCustom.transparent,
        tabs: _items
            .map(
              (e) => Tab(
                iconMargin: const PagePadding.onlyBottomVeryLow(),
                text: e.title.tr(),
                icon: e.icon,
              ),
            )
            .toList(),
      ),
    );
  }

  TabBarView bodyTabBarView() {
    return TabBarView(
      children: _items.map((e) => e.page).toList(),
    );
  }
}

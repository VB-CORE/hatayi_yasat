import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/company/request_company_view.dart';
import 'package:vbaseproject/features/request/project/request_project_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/appbar/main_appbar.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial_child.dart';
import 'package:vbaseproject/sub_feature/tab/model/tab_model.dart';

final class MainTabView extends StatelessWidget {
  MainTabView({super.key});

  final tabItems = TabModels.create().tabItems;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabItems.length,
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: MainAppBar(context: context),
        body: _BodyTabBarViewWidget(tabItems: tabItems),
        bottomNavigationBar: _BottomAppBarWidget(tabItems: tabItems),
        floatingActionButton: const _SpeedDialFabWidget(),
      ),
    );
  }
}

class _BodyTabBarViewWidget extends StatelessWidget {
  const _BodyTabBarViewWidget({
    required this.tabItems,
  });

  final List<TabModel> tabItems;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: tabItems.map((e) => e.page).toList(),
    );
  }
}

class _BottomAppBarWidget extends StatelessWidget {
  const _BottomAppBarWidget({
    required this.tabItems,
  });

  final List<TabModel> tabItems;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      notchMargin: WidgetSizes.spacingXs,
      shape: const CircularNotchedRectangle(),
      child: TabBar(
        dividerColor: ColorsCustom.transparent,
        labelStyle: context.general.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.bold),
        tabs: tabItems
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
}

class _SpeedDialFabWidget extends StatelessWidget {
  const _SpeedDialFabWidget();

  @override
  Widget build(BuildContext context) {
    return CustomSpeedDial(
      children: [
        CustomSpeedDialChild(
          context: context,
          destination: const RequestProjectView(),
          label: LocaleKeys.projectRequest_title,
        ),
        CustomSpeedDialChild(
          context: context,
          destination: const RequestCompanyView(),
          label: LocaleKeys.requestCompany_title,
        ),
      ],
    );
  }
}

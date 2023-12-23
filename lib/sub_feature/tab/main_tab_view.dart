import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial.dart';
import 'package:vbaseproject/product/widget/speed_dial/custom_speed_dial_child.dart';
import 'package:vbaseproject/sub_feature/tab/mixin/main_tab_view_mixin.dart';
import 'package:vbaseproject/sub_feature/tab/model/speed_dial_child_model.dart';
import 'package:vbaseproject/sub_feature/tab/model/tab_model.dart';

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
    ref.listen(ProductProvider.provider, (previous, next) {
      if (previous?.redirectionPage != next.redirectionPage) {
        controller.animateTo(previous!.redirectionPage!.index);
      }
    });

    return DefaultTabController(
      length: _tabItems.length,
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _BodyTabBarViewWidget(tabItems: _tabItems),
        bottomNavigationBar: _BottomAppBarWidget(tabItems: _tabItems),
        floatingActionButton: _SpeedDialFabWidget(dialItems: _speedDialItems),
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
      color: context.general.colorScheme.secondary,
      child: TabBar(
        padding: EdgeInsets.zero,
        dividerColor: ColorsCustom.transparent,
        tabs: tabItems
            .map(
              (e) => Tab(
                icon: e.icon,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SpeedDialFabWidget extends StatelessWidget {
  const _SpeedDialFabWidget({required this.dialItems});

  final List<SpeedDialChildModel> dialItems;

  @override
  Widget build(BuildContext context) {
    return CustomSpeedDial(
      children: dialItems
          .map(
            (e) => CustomSpeedDialChild(
              context: context,
              destination: e.destination,
              label: e.title,
            ),
          )
          .toList(),
    );
  }
}

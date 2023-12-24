part of '../main_tab_view.dart';

class _BodyTabBarViewWidget extends StatelessWidget {
  const _BodyTabBarViewWidget({
    required this.tabItems,
  });

  final List<TabModel> tabItems;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(WidgetSizes.spacingXxl2),
      child: BottomAppBar(
        height: WidgetSizes.spacingXxl8,
        padding: EdgeInsets.zero,
        notchMargin: WidgetSizes.spacingXs,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: TabBar(
          padding: EdgeInsets.zero,
          dividerColor: ColorsCustom.transparent,
          labelPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: tabItems
              .map(
                (e) => Tab(child: e.icon),
              )
              .toList(),
        ),
      ),
    );
  }
}

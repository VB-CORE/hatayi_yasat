part of '../monetization_view.dart';

enum MonetizationCouponTab {
  active,
  inactive;

  String title(int count) {
    switch (this) {
      case MonetizationCouponTab.active:
        return LocaleKeys.monetization_activeTab.tr(args: ['$count']);
      case MonetizationCouponTab.inactive:
        return LocaleKeys.monetization_inactiveTab.tr(args: ['$count']);
    }
  }
}

final class _MonetizationTabBar extends StatelessWidget {
  const _MonetizationTabBar({
    required this.activeCount,
    required this.inactiveCount,
  });

  final int activeCount;
  final int inactiveCount;

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.general.textTheme.titleSmall;

    return Padding(
      padding: const PagePadding.onlyTop(),
      child: TabBar(
        dividerColor: ColorsCustom.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.coral,
            width: 2,
          ),
        ),
        labelColor: AppColors.ink700,
        unselectedLabelColor: AppColors.ink400,
        labelStyle: labelStyle?.copyWith(fontWeight: FontWeight.w900),
        unselectedLabelStyle: labelStyle,
        tabs: [
          Tab(text: MonetizationCouponTab.active.title(activeCount)),
          Tab(text: MonetizationCouponTab.inactive.title(inactiveCount)),
        ],
      ),
    );
  }
}

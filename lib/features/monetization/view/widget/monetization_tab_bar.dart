import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';

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

final class MonetizationTabBar extends StatelessWidget {
  const MonetizationTabBar({
    required this.activeCount,
    required this.inactiveCount,
    super.key,
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

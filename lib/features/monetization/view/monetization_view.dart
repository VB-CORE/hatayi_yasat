import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_mock.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/extension/number_extension.dart';
import 'package:lifeclient/product/widget/app_bar/app_bar_action.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/monetization_body_view.dart';
part 'widget/monetization_card.dart';
part 'widget/monetization_tab_bar.dart';

final class MonetizationView extends StatelessWidget {
  const MonetizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final coupons = DiscountCouponMock.mockDiscountCoupons;
    final activeCoupons = coupons
        .where((coupon) => !coupon.isInactive)
        .toList();
    final inactiveCoupons = coupons
        .where((coupon) => coupon.isInactive)
        .toList();

    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.monetization_title,
        actionsPadding: const PagePadding.horizontalLowSymmetric(),
        actions: [
          AppBarAction(
            title: LocaleKeys.monetization_addCouponAction.tr(),
            icon: AppIcons.add,
            onPressed: () => const MonetizationCouponFormRoute().push<void>(
              context,
            ),
          ),
        ],
      ),
      body: coupons.isEmpty
          ? GeneralNotFoundWidget(
              title: LocaleKeys.monetization_emptyCoupons.tr(),
            )
          : DefaultTabController(
              length: MonetizationCouponTab.values.length,
              child: Column(
                children: [
                  _MonetizationTabBar(
                    activeCount: activeCoupons.length,
                    inactiveCount: inactiveCoupons.length,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _MonetizationBodyView(coupons: activeCoupons),
                        _MonetizationBodyView(coupons: inactiveCoupons),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

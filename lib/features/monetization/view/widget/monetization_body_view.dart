import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/features/monetization/view/widget/monetization_card.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

final class MonetizationBodyView extends StatelessWidget {
  const MonetizationBodyView({required this.coupons, super.key});

  final List<DiscountCouponModel> coupons;

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.monetization_emptyCoupons.tr(),
      );
    }

    return ListView.separated(
      padding: const PagePadding.onlyTop(),
      separatorBuilder: (context, index) => const EmptyBox.smallHeight(),
      itemCount: coupons.length,
      itemBuilder: (_, index) => MonetizationCard(coupon: coupons[index]),
    );
  }
}

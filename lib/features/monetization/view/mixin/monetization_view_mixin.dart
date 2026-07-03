import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/features/monetization/provider/monetization_view_model.dart';
import 'package:lifeclient/features/monetization/view/monetization_view.dart';
import 'package:lifeclient/features/monetization/view/sheet/monetization_coupon_delete_sheet.dart';
import 'package:lifeclient/features/monetization/view/sheet/monetization_coupon_form_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin MonetizationViewMixin
    on ConsumerState<MonetizationView>, AppProviderMixin<MonetizationView> {
  @override
  void initState() {
    super.initState();

    unawaited(
      Future.microtask(() async {
        await ref.read(monetizationViewModelProvider.notifier).fetchCoupons();
      }),
    );
  }

  List<Widget> buildAppBarActions() {
    return [
      IconButton(
        tooltip: LocaleKeys.monetization_addCoupon.tr(),
        onPressed: onAddCouponPressed,
        icon: const Icon(AppIcons.add),
      ),
    ];
  }

  Future<void> onAddCouponPressed() async {
    final coupon = await MonetizationCouponFormSheet.show(context: context);
    if (coupon == null) return;

    await ref.read(monetizationViewModelProvider.notifier).addCoupon(coupon);
  }

  Future<void> onEditCouponPressed(DiscountCouponModel coupon) async {
    final updatedCoupon = await MonetizationCouponFormSheet.show(
      context: context,
      coupon: coupon,
    );
    if (updatedCoupon == null) return;

    await ref
        .read(monetizationViewModelProvider.notifier)
        .updateCoupon(updatedCoupon);
  }

  Future<void> onDeleteCouponPressed(DiscountCouponModel coupon) async {
    final confirmed = await MonetizationCouponDeleteSheet.show(
      context: context,
    );
    if (!confirmed) return;

    await ref
        .read(monetizationViewModelProvider.notifier)
        .deleteCoupon(coupon.documentId);
  }
}

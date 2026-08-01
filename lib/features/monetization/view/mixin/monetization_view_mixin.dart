import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/monetization/provider/monetization_view_model.dart';
import 'package:lifeclient/features/monetization/view/monetization_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

mixin MonetizationViewMixin
    on ConsumerState<MonetizationView>, AppProviderMixin<MonetizationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      unawaited(
        ref.read(monetizationViewModelProvider.notifier).fetchCoupons(),
      );
    });
  }

  void onRedeem(CouponModel coupon) =>
      CouponRedeemRoute($extra: coupon).go(context);

  void onEdit(CouponModel coupon) =>
      MonetizationCouponFormRoute($extra: coupon).go(context);

  Future<void> onDelete(CouponModel coupon) async {
    final isConfirmed = await GeneralTextDialog.show<bool>(
      context,
      LocaleKeys.monetization_deleteConfirmTitle.tr(),
      LocaleKeys.monetization_deleteConfirmContent.tr(),
      [
        GeneralDialogButton(
          title: LocaleKeys.button_cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        GeneralDialogButton(
          title: LocaleKeys.button_iAmSure,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
      backgroundColor: context.general.colorScheme.surface,
    );
    if (isConfirmed != true) return;

    final isDeleted = await ref
        .read(monetizationViewModelProvider.notifier)
        .deleteCoupon(coupon);

    appProvider.showSnackbarMessage(
      isDeleted
          ? LocaleKeys.monetization_deleteSuccess.tr()
          : LocaleKeys.message_somethingWentWrong.tr(),
    );
  }
}

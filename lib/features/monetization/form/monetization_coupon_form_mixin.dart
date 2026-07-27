import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/monetization/form/monetization_coupon_form_view.dart';
import 'package:lifeclient/features/monetization/provider/monetization_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin MonetizationCouponFormMixin
    on
        ConsumerState<MonetizationCouponFormView>,
        AppProviderMixin<MonetizationCouponFormView> {
  final formKey = GlobalKey<FormState>();
  final descController = TextEditingController();
  final usageLimitController = TextEditingController();
  final discountRateNotifier = ValueNotifier<int>(
    MonetizationDiscountRateSlider.minRate,
  );

  DateTime? expiresAt;

  @override
  void dispose() {
    descController.dispose();
    usageLimitController.dispose();
    discountRateNotifier.dispose();
    super.dispose();
  }

  Future<void> saveCoupon() async {
    if (formKey.currentState?.validate() != true || expiresAt == null) return;

    final usageLimitText = usageLimitController.text.trim();
    final usageLimit = int.tryParse(usageLimitText);

    final isCreated = await ref
        .read(monetizationViewModelProvider.notifier)
        .addCoupon(
          desc: descController.text.trim(),
          rate: discountRateNotifier.value,
          expiresAt: expiresAt!,
          usageLimit: usageLimit,
        );

    if (!mounted) return;

    if (!isCreated) {
      return appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
    }

    appProvider.showSnackbarMessage(LocaleKeys.monetization_addSuccess.tr());
    context.pop();
  }
}

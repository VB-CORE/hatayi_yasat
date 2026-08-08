import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
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

  CouponModel? get editedCoupon => widget.coupon;

  bool get isEditing => editedCoupon != null;

  @override
  void initState() {
    super.initState();
    final coupon = editedCoupon;
    if (coupon == null) return;
    descController.text = coupon.desc ?? '';
    usageLimitController.text = coupon.usageLimit?.toString() ?? '';
    discountRateNotifier.value =
        coupon.ratio ?? MonetizationDiscountRateSlider.minRate;
    expiresAt = coupon.expiresAt;
  }

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

    final notifier = ref.read(monetizationViewModelProvider.notifier);
    final coupon = editedCoupon;

    final isSaved = coupon == null
        ? await notifier.addCoupon(
            desc: descController.text.trim(),
            rate: discountRateNotifier.value,
            expiresAt: expiresAt!,
            usageLimit: usageLimit,
          )
        : await notifier.updateCoupon(
            coupon: coupon,
            desc: descController.text.trim(),
            rate: discountRateNotifier.value,
            expiresAt: expiresAt!,
            usageLimit: usageLimit,
          );

    if (!mounted) return;

    if (!isSaved) {
      return appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
    }

    appProvider.showSnackbarMessage(
      coupon == null
          ? LocaleKeys.monetization_addSuccess.tr()
          : LocaleKeys.monetization_updateSuccess.tr(),
    );
    context.pop();
  }
}

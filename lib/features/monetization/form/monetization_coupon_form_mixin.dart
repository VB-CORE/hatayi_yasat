import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/monetization/form/monetization_coupon_form_view.dart';
import 'package:lifeclient/features/monetization/form/widget/monetization_discount_rate_slider.dart';

mixin MonetizationCouponFormMixin on State<MonetizationCouponFormView> {
  final formKey = GlobalKey<FormState>();
  final descController = TextEditingController();
  final usageLimitController = TextEditingController();
  final expiresAtController = TextEditingController();
  final discountRateNotifier = ValueNotifier<int>(
    MonetizationDiscountRateSlider.minRate,
  );

  DateTime? _expiresAt;

  @override
  void dispose() {
    descController.dispose();
    usageLimitController.dispose();
    expiresAtController.dispose();
    discountRateNotifier.dispose();
    super.dispose();
  }

  Future<void> pickExpiryDate() async {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime(now.year + 1),
    );
    if (selectedDate == null || !mounted) return;

    _expiresAt = selectedDate;
    expiresAtController.text = DateFormat.yMMMd(
      context.locale.toLanguageTag(),
    ).format(selectedDate);
  }

  void saveCoupon() {
    if (formKey.currentState?.validate() != true || _expiresAt == null) return;
    context.pop();
  }
}

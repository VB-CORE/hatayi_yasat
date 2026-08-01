import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/monetization/form/monetization_coupon_form_mixin.dart';
import 'package:lifeclient/features/monetization/provider/monetization_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/text_field/date_time_form_field.dart';
import 'package:lifeclient/product/widget/text_field/labeled_product_textfield.dart';

part 'widget/monetization_discount_rate_slider.dart';

@immutable
final class MonetizationCouponFormView extends ConsumerStatefulWidget {
  const MonetizationCouponFormView({super.key, this.coupon});

  final CouponModel? coupon;

  @override
  ConsumerState<MonetizationCouponFormView> createState() =>
      _MonetizationCouponFormViewState();
}

final class _MonetizationCouponFormViewState
    extends ConsumerState<MonetizationCouponFormView>
    with
        AppProviderMixin<MonetizationCouponFormView>,
        MonetizationCouponFormMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bg,
      appBar: PageAppBar(
        pageTitle: isEditing
            ? LocaleKeys.monetization_editCoupon
            : LocaleKeys.monetization_addCoupon,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const PagePadding.horizontal16Symmetric(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const EmptyBox.smallHeight(),
              LabeledProductTextField(
                controller: descController,
                labelText: LocaleKeys.monetization_couponDesc.tr(),
                hintText: LocaleKeys.monetization_couponDescHint.tr(),
                validator: ValidatorNormalTextField().validate,
              ),
              const EmptyBox.middleHeight(),
              ValueListenableBuilder<int>(
                valueListenable: discountRateNotifier,
                builder: (context, discountRate, _) {
                  return MonetizationDiscountRateSlider(
                    value: discountRate,
                    onChanged: (rate) => discountRateNotifier.value = rate,
                  );
                },
              ),
              const EmptyBox.smallHeight(),
              LabeledProductTextField(
                controller: usageLimitController,
                labelText: LocaleKeys.monetization_usageLimit.tr(),
                hintText: LocaleKeys.monetization_usageLimitHint.tr(),
                keyboardType: TextInputType.number,
                formatters: [FilteringTextInputFormatter.digitsOnly],
                validator: ValidatorNumericRangeTextField(
                  min: 1,
                  isOptional: true,
                ).validate,
              ),
              const EmptyBox.smallHeight(),
              DateTimeFormField(
                labelText: LocaleKeys.monetization_expiryDateLabel.tr(),
                hintText: LocaleKeys.monetization_expiryDateLabel.tr(),
                initialDate: expiresAt,
                onDateSelected: (value) => expiresAt = value,
              ),
              const EmptyBox.smallHeight(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _MonetizationCouponFormSaveButton(
        onSave: saveCoupon,
      ),
    );
  }
}

final class _MonetizationCouponFormSaveButton extends ConsumerWidget {
  const _MonetizationCouponFormSaveButton({required this.onSave});

  final Future<void> Function() onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitting = ref.watch(
      monetizationViewModelProvider.select((state) => state.isSubmitting),
    );

    return BottomAppBar(
      child: GeneralButtonV2.async(
        action: onSave,
        isEnabled: !isSubmitting,
        label: LocaleKeys.button_save.tr(),
      ),
    );
  }
}

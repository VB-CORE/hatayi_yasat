import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/monetization/form/monetization_coupon_form_mixin.dart';
import 'package:lifeclient/features/monetization/form/widget/monetization_discount_rate_slider.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/text_field/labeled_product_textfield.dart';

@immutable
final class MonetizationCouponFormView extends StatefulWidget {
  const MonetizationCouponFormView({super.key});

  @override
  State<MonetizationCouponFormView> createState() =>
      _MonetizationCouponFormViewState();
}

class _MonetizationCouponFormViewState extends State<MonetizationCouponFormView>
    with MonetizationCouponFormMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bg,
      appBar: PageAppBar(pageTitle: LocaleKeys.monetization_addCoupon),
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
              LabeledProductTextField(
                controller: expiresAtController,
                labelText: LocaleKeys.monetization_expiryDateLabel.tr(),
                hintText: LocaleKeys.monetization_expiryDateLabel.tr(),
                readOnly: true,
                suffixIcon: AppIcons.calendar,
                onTap: pickExpiryDate,
                validator: TextFieldValidatorIsNullEmpty().validate,
              ),
              const EmptyBox.smallHeight(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GeneralButtonV2.active(
          action: saveCoupon,
          label: LocaleKeys.button_save.tr(),
        ),
      ),
    );
  }
}

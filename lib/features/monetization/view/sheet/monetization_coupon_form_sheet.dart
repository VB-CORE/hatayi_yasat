import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/divider/sheet_gap_divider.dart';
import 'package:lifeclient/product/widget/general/general_button.dart';
import 'package:lifeclient/product/widget/general/general_check_box.dart';
import 'package:lifeclient/product/widget/general/title/general_sub_title.dart';
import 'package:lifeclient/product/widget/text_field/labeled_product_textfield.dart';

@immutable
final class MonetizationCouponFormSheet extends StatefulWidget {
  const MonetizationCouponFormSheet({this.coupon, super.key});

  final DiscountCouponModel? coupon;

  static Future<DiscountCouponModel?> show({
    required BuildContext context,
    DiscountCouponModel? coupon,
  }) {
    return showModalBottomSheet<DiscountCouponModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: MonetizationCouponFormSheet(coupon: coupon),
        );
      },
    );
  }

  @override
  State<MonetizationCouponFormSheet> createState() =>
      _MonetizationCouponFormSheetState();
}

class _MonetizationCouponFormSheetState
    extends State<MonetizationCouponFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _nameController;
  late final TextEditingController _discountRateController;
  late final TextEditingController _expiresAtController;
  DateTime? _expiresAt;
  late bool _isActive;
  var _isExpiryTextInitialized = false;

  bool get _isEditing => widget.coupon != null;

  @override
  void initState() {
    super.initState();
    final coupon = widget.coupon;
    _codeController = TextEditingController(text: coupon?.code ?? '');
    _nameController = TextEditingController(text: coupon?.name ?? '');
    _discountRateController = TextEditingController(
      text: coupon?.discountRate?.toString() ?? '',
    );
    _expiresAt = coupon?.expiresAt;
    _expiresAtController = TextEditingController();
    _isActive = coupon?.isActive ?? true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isExpiryTextInitialized || _expiresAt == null) return;

    _expiresAtController.text = DateFormat.yMMMEd(
      context.locale.toLanguageTag(),
    ).format(_expiresAt!.toLocal());
    _isExpiryTextInitialized = true;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _discountRateController.dispose();
    _expiresAtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const PagePadding.all(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetGapDivider(),
          GeneralSubTitle(
            value: _isEditing
                ? LocaleKeys.monetization_editCoupon.tr()
                : LocaleKeys.monetization_addCoupon.tr(),
            fontWeight: FontWeight.bold,
          ),
          const EmptyBox.smallHeight(),
          Form(
            key: _formKey,
            child: Column(
              children: [
                LabeledProductTextField(
                  controller: _codeController,
                  labelText: LocaleKeys.monetization_couponCode.tr(),
                  validator: TextFieldValidatorIsNullEmpty().validate,
                ),
                const EmptyBox.smallHeight(),
                LabeledProductTextField(
                  controller: _nameController,
                  labelText: LocaleKeys.monetization_couponName.tr(),
                  validator: ValidatorNormalTextField().validate,
                ),
                const EmptyBox.smallHeight(),
                LabeledProductTextField(
                  controller: _discountRateController,
                  labelText: LocaleKeys.monetization_discountRate.tr(),
                  keyboardType: TextInputType.number,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _validateDiscountRate,
                ),
                const EmptyBox.smallHeight(),
                LabeledProductTextField(
                  controller: _expiresAtController,
                  labelText: LocaleKeys.monetization_expiryDateLabel.tr(),
                  hintText: LocaleKeys.monetization_expiryDateLabel.tr(),
                  readOnly: true,
                  suffixIcon: AppIcons.calendar,
                  onTap: _pickExpiryDate,
                  validator: TextFieldValidatorIsNullEmpty().validate,
                ),
                GeneralCheckBox(
                  value: _isActive,
                  title: LocaleKeys.monetization_isActive.tr(),
                  onUpdate: (value) => setState(() => _isActive = value),
                ),
              ],
            ),
          ),
          const EmptyBox.smallHeight(),
          GeneralButtonV2.active(
            action: _onSave,
            label: LocaleKeys.button_save.tr(),
          ),
          TextButton(
            onPressed: () => context.route.pop(),
            child: Text(LocaleKeys.button_cancel.tr()),
          ),
        ],
      ),
    );
  }

  Future<void> _pickExpiryDate() async {
    final dateTimeModel = await DateTimePicker.selectedDateTime(context);
    if (dateTimeModel == null) return;

    setState(() {
      _expiresAt = dateTimeModel.dateTime;
      _expiresAtController.text = dateTimeModel.formattedText;
    });
  }

  String? _validateDiscountRate(String? value) {
    final requiredError = TextFieldValidatorIsNullEmpty().validate(value);
    if (requiredError != null) return requiredError;

    final rate = int.tryParse(value!);
    if (rate == null || rate < 1 || rate > 100) {
      return LocaleKeys.monetization_invalidDiscountRate.tr();
    }
    return null;
  }

  void _onSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_expiresAt == null) return;

    final coupon = DiscountCouponModel(
      documentId: widget.coupon?.documentId ?? '',
      code: _codeController.text.trim(),
      name: _nameController.text.trim(),
      discountRate: int.parse(_discountRateController.text.trim()),
      expiresAt: _expiresAt,
      isActive: _isActive,
      storeId: widget.coupon?.storeId,
      storeName: widget.coupon?.storeName,
      createdBy: widget.coupon?.createdBy,
      createdAt: widget.coupon?.createdAt,
      updatedAt: widget.coupon?.updatedAt,
    );

    unawaited(context.route.pop(coupon));
  }
}

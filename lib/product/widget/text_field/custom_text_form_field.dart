import 'package:flutter/material.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_auto_fills.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_formatters.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_decoration.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_model.dart';

final class CustomTextFormField extends StatelessWidget
    with CustomTextFieldModel {
  const CustomTextFormField({
    required this.hint,
    required this.controller,
    required this.validator,
    this.textInputType = TextInputType.text,
    this.maxLength = TextFieldMaxLengths.none,
    this.formatters = TextFieldFormatters.none,
    this.autoFills = TextFieldAutoFills.normal,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  @override
  final String hint;
  @override
  final TextEditingController controller;
  @override
  final TextInputType textInputType;
  @override
  final TextFieldMaxLengths maxLength;
  @override
  final TextFieldFormatters formatters;
  @override
  final ValidatorField validator;
  @override
  final TextFieldAutoFills autoFills;
  @override
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength.value,
      inputFormatters: formatters.value,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      validator: validator.validate,
      autofillHints: autoFills.value,
      decoration: CustomTextFieldDecoration(
        // hint: hint,
        context: context,
      ),
    );
  }
}

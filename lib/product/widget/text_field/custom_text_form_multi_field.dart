import 'package:flutter/material.dart';
import 'package:lifeclient/product/model/enum/text_field/index.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_decoration.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_model.dart';

final class CustomTextFormMultiField extends StatelessWidget
    with CustomTextFieldModel {
  const CustomTextFormMultiField({
    required this.hint,
    required this.controller,
    required this.validator,
    this.textInputType = TextInputType.text,
    this.maxLength = TextFieldMaxLengths.none,
    this.autoFills = TextFieldAutoFills.normal,
    this.formatters = TextFieldFormatters.none,
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
  final TextFieldAutoFills autoFills;
  @override
  final ValidatorField validator;
  @override
  final TextFieldFormatters formatters;
  @override
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofillHints: autoFills.value,
      minLines: 3,
      maxLines: TextFieldMaxLengths.maxLine,
      keyboardType: textInputType,
      validator: validator.validate,
      textInputAction: textInputAction,
      inputFormatters: formatters.value,
      decoration: CustomTextFieldDecoration(context: context),
    );
  }
}

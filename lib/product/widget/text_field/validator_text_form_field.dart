import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';

class ValidatorTextFormField extends StatelessWidget {
  const ValidatorTextFormField({
    required this.labelText,
    required this.validator,
    required this.controller,
    super.key,
    this.minLine,
  });
  final String labelText;
  final ValidatorField validator;
  final int? minLine;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: TextFormField(
        minLines: minLine,
        controller: controller,
        maxLines: minLine != null ? minLine! + 1 : null,
        decoration: InputDecoration(
          labelText: labelText.tr(),
          border: const OutlineInputBorder(),
        ),
        validator: validator.validate,
      ),
    );
  }
}

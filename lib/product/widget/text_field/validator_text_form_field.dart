import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';

class ValidatorTextFormField extends StatelessWidget {
  const ValidatorTextFormField({
    required this.labelText,
    required this.validator,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    super.key,
    this.minLine,
  });
  final String labelText;
  final ValidatorField validator;
  final int? minLine;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: TextFormField(
        minLines: minLine,
        controller: controller,
        maxLines: minLine != null ? minLine! + 1 : null,
        textInputAction: textInputAction,
        style: context.general.textTheme.labelLarge?.copyWith(
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
        decoration: InputDecoration(
          labelText: labelText.tr(),
          labelStyle: context.general.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorCommon(context).whiteAndBlackForTheme,
          ),
          border: const OutlineInputBorder(),
        ),
        validator: validator.validate,
      ),
    );
  }
}

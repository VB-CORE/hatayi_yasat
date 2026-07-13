import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/product_text_field_decoration.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_decoration.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    required this.validator,
    super.key,
    this.isMultiline = false,
    this.formatters,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.maxLength = TextFieldMaxLengths.none,
  });
  final bool isMultiline;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? formatters;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? suffixIcon;
  final TextFieldMaxLengths maxLength;

  @override
  Widget build(BuildContext context) {
    final decoration =
        (suffixIcon != null
                ? CustomDateTimeFieldDecoration(
                    context: context,
                    suffixIcon: suffixIcon,
                    hint: hintText,
                  )
                : ProductTextFieldDecoration(context, hintText))
            .copyWith(counter: const SizedBox());

    return TextFormField(
      controller: controller,
      inputFormatters: formatters,
      keyboardType: keyboardType,
      maxLines: isMultiline ? AppConstants.kFour : AppConstants.kOne,
      maxLength: maxLength.value,
      cursorColor: context.general.colorScheme.onSurface,
      decoration: decoration,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}

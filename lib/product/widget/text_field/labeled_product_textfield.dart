import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/widget/text_field/product_textfield.dart';
import 'package:lifeclient/product/widget/text_field/widget/custom_text_field_label.dart';

class LabeledProductTextField extends StatelessWidget {
  const LabeledProductTextField({
    required this.validator,
    required this.labelText,
    super.key,
    this.isRequired = true,
    this.isMultiline = false,
    this.formatters,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });
  final String labelText;
  final bool isRequired;
  final bool isMultiline;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? formatters;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldLabel(labelText: labelText, isRequired: isRequired),
        context.sized.emptySizedHeightBoxLow,
        ProductTextField(
          hintText: hintText,
          formatters: formatters,
          isMultiline: isMultiline,
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}

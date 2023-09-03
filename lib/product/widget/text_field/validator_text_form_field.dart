import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

abstract class ValidatorField {
  String? validate(String? value);
}

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
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: validator.validate,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

final class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hint,
    required this.controller,
    super.key,
  });
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        focusColor: context.general.colorScheme.onError,
        focusedBorder: OutlineInputBorder(
          borderRadius: CustomRadius.extraLarge,
          borderSide: BorderSide(color: context.general.colorScheme.primary),
        ),
        hintStyle: context.general.textTheme.titleMedium,
        border: const OutlineInputBorder(
          borderRadius: CustomRadius.extraLarge,
        ),
        contentPadding: const PagePadding.horizontalSymmetric(),
      ),
    );
  }
}

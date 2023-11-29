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
      style: context.general.textTheme.titleLarge?.copyWith(
        color: context.general.colorScheme.onBackground,
      ),
      decoration: InputDecoration(
        labelText: hint,
        focusColor: context.general.colorScheme.onError,
        focusedBorder: OutlineInputBorder(
          borderRadius: CustomRadius.small,
          borderSide: BorderSide(color: context.general.colorScheme.primary),
        ),
        hintStyle: context.general.textTheme.titleMedium,
        border: const OutlineInputBorder(
          borderRadius: CustomRadius.small,
        ),
        contentPadding: const PagePadding.horizontalSymmetric(),
      ),
    );
  }
}

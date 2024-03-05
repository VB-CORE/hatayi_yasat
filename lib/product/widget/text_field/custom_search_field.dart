import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

final class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    required this.hint,
    required this.onChange,
    super.key,
  });
  final String hint;
  final ValueChanged<String> onChange;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        focusColor: context.general.colorScheme.onError,
        focusedBorder: OutlineInputBorder(
          borderRadius: CustomRadius.medium,
          borderSide: BorderSide(color: context.general.colorScheme.primary),
        ),
        hintStyle: context.general.textTheme.titleMedium,
        border: const OutlineInputBorder(
          borderRadius: CustomRadius.medium,
        ),
        contentPadding: const PagePadding.horizontalSymmetric(),
        suffixIcon: const Icon(Icons.search_outlined),
      ),
    );
  }
}

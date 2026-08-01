import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

final class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    required this.hint,
    this.onChange,
    this.onTap,
    this.readOnly = false,
    this.textFieldKey,
    super.key,
  });

  final String hint;
  final ValueChanged<String>? onChange;
  final VoidCallback? onTap;
  final bool readOnly;
  final Key? textFieldKey;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: textFieldKey,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.general.colorScheme.outlineVariant,
        hintText: hint,
        hintStyle: context.general.textTheme.bodyMedium?.copyWith(
          color: context.general.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(
          AppIcons.search,
          color: context.general.colorScheme.onSurfaceVariant,
        ),
        border: _searchBorder,
        enabledBorder: _searchBorder,
        focusedBorder: _searchBorder,
      ),
    );
  }

  OutlineInputBorder get _searchBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.md),
    borderSide: BorderSide.none,
  );
}

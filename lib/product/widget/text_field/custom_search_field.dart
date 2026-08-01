import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_text.dart';
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
        fillColor: AppColors.ink50,
        hintText: hint,
        hintStyle: AppText.body.copyWith(color: AppColors.ink400),
        prefixIcon: const Icon(AppIcons.search, color: AppColors.ink400),
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

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

class SearchFieldDisabled extends StatelessWidget {
  const SearchFieldDisabled({
    required this.onTap,
    super.key,
    this.hint,
    this.suffixIcon,
  });
  final String? hint;
  final VoidCallback onTap;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextField(
        onTap: onTap,
        decoration: InputDecoration(
          enabled: false,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.search),
          hintText: hint,
          filled: true,
          hintStyle: context.general.textTheme.labelLarge?.copyWith(
            color: ColorCommon(context).whiteAndBlackForTheme,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: CustomRadius.extraLarge,
            borderSide: BorderSide(
              color: context.general.appTheme.colorScheme.onBackground,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: CustomRadius.extraLarge,
            borderSide: BorderSide(
              color: context.general.appTheme.colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/product_text_field_decoration.dart';

final class CustomTextFieldDecoration extends InputDecoration {
  CustomTextFieldDecoration({
    required BuildContext context,
    String? hint,
  }) : super(
          hintText: hint,
          contentPadding: const PagePadding.horizontal16Symmetric() +
              const PagePadding.vertical8Symmetric(),
          border: ProductTextFieldDecoration.standardBorder(context),
          enabledBorder: ProductTextFieldDecoration.standardBorder(context),
          focusedBorder: ProductTextFieldDecoration.focusedBorderStyle(context),
          fillColor: context.general.colorScheme.onPrimaryFixed,
          filled: true,
          counter: const SizedBox(),
          hintStyle: context.general.textTheme.titleSmall?.copyWith(
            color: context.general.colorScheme.onPrimaryFixedVariant,
          ),
        );
}

final class CustomTimeFieldDecoration extends InputDecoration {
  CustomTimeFieldDecoration({
    required BuildContext context,
    String? hint,
    IconData? prefixIcon,
  }) : super(
          prefixIcon: Icon(
            prefixIcon,
            color: context.general.colorScheme.onSecondaryFixed,
          ),
          hintText: hint,
          contentPadding: const PagePadding.horizontal16Symmetric(),
          border: ProductTextFieldDecoration.thickerStandardBorder(
            context,
          ),
          enabledBorder: ProductTextFieldDecoration.thickerStandardBorder(
            context,
          ),
          focusedBorder: ProductTextFieldDecoration.thickerStandardBorder(
            context,
          ),
          hintStyle: context.general.textTheme.titleSmall?.copyWith(
            color: context.general.colorScheme.onPrimaryFixedVariant,
          ),
        );
}

final class CustomDateTimeFieldDecoration extends InputDecoration {
  CustomDateTimeFieldDecoration({
    required BuildContext context,
    String? hint,
    IconData? suffixIcon,
  }) : super(
          suffixIcon: Icon(
            suffixIcon,
            color: context.general.colorScheme.onSecondaryFixed,
          ),
          hintText: hint,
          contentPadding: const PagePadding.horizontal16Symmetric(),
          border: ProductTextFieldDecoration.thickerStandardBorder(
            context,
          ),
          enabledBorder: ProductTextFieldDecoration.thickerStandardBorder(
            context,
          ),
          focusedBorder: ProductTextFieldDecoration.thickerStandardBorder(
            context,
          ),
          hintStyle: context.general.textTheme.titleSmall?.copyWith(
            color: context.general.colorScheme.onPrimaryFixedVariant,
          ),
        );
}

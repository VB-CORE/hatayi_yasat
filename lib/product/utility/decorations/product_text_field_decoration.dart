import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

class ProductTextFieldDecoration extends InputDecoration {
  ProductTextFieldDecoration(BuildContext context, String? hintText)
    : super(
        contentPadding: context.padding.low,
        filled: true,
        fillColor: context.general.colorScheme.onPrimaryFixed,
        enabledBorder: focusedBorderStyle(context),
        focusedBorder: focusedBorderStyle(context),
        border: standardBorder(context),
        hintText: hintText,
        hintStyle: context.general.textTheme.titleSmall?.copyWith(
          color: context.general.colorScheme.onSecondaryFixed,
        ),
      );

  static OutlineInputBorder focusedBorderStyle(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: context.general.colorScheme.primary,
      ),
    );
  }

  static OutlineInputBorder standardBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: context.general.colorScheme.onPrimaryContainer,
        ),
      );

  static OutlineInputBorder thickerStandardBorder(
    BuildContext context,
  ) => OutlineInputBorder(
    borderRadius: mediumBorderRadius,
    borderSide: BorderSide(
      color: context.general.colorScheme.onPrimaryContainer,
      width: 2,
    ),
  );

  static BorderRadius get borderRadius => const BorderRadius.all(
    Radius.circular(WidgetSizes.spacingS),
  );

  static BorderRadius get mediumBorderRadius => const BorderRadius.all(
    Radius.circular(WidgetSizes.spacingM),
  );
}

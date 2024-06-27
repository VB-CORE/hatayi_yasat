// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';

class ProductTextFieldDecoration extends InputDecoration {
  ProductTextFieldDecoration(BuildContext context, String? hintText)
      : super(
          contentPadding: context.padding.low,
          enabledBorder: focusedBorderStyle(context),
          focusedBorder: focusedBorderStyle(context),
          border: standardBorder(context),
          hintText: hintText,
          hintStyle: context.general.textTheme.titleSmall?.copyWith(
            color: ColorsCustom.lightGray,
          ),
        );

  static OutlineInputBorder focusedBorderStyle(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(
        color: ColorsCustom.warmGrey,
      ),
    );
  }

  static OutlineInputBorder standardBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(
          color: ColorsCustom.softGray,
        ),
      );

  static OutlineInputBorder thickerStandardBorder(
    BuildContext context,
  ) =>
      OutlineInputBorder(
        borderRadius: mediumBorderRadius,
        borderSide: const BorderSide(
          color: ColorsCustom.softGray,
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

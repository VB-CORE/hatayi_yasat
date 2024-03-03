// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

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
        color: ColorsCustom.lightGray,
      ),
    );
  }

  static OutlineInputBorder standardBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: ColorsCustom.lightGray,
          width: context.sized.dynamicWidth(0.1),
        ),
      );

  static BorderRadius get borderRadius => const BorderRadius.all(
        Radius.circular(kIsWeb ? WidgetSizes.spacingS : WidgetSizes.spacingM),
      );
}

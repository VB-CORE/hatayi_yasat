import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/product_text_field_decoration.dart';

final class CustomDropdownDecoration extends InputDecoration {
  CustomDropdownDecoration({
    required BuildContext context,
  }) : super(
          contentPadding: const PagePadding.horizontal16Symmetric(),
          border: ProductTextFieldDecoration.standardBorder(context),
          enabledBorder: ProductTextFieldDecoration.standardBorder(context),
          focusedBorder: ProductTextFieldDecoration.standardBorder(context),
          fillColor: context.general.colorScheme.onPrimaryFixed,
          filled: true,
          hintStyle: context.general.textTheme.titleSmall?.copyWith(
            color: context.general.colorScheme.onPrimaryFixedVariant,
          ),
        );
}

import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/product_text_field_decoration.dart';

final class CustomTextFieldDecoration extends InputDecoration {
  CustomTextFieldDecoration({
    required BuildContext context,
    String? hint,
  }) : super(
         hintText: hint,
         contentPadding:
             const PagePadding.horizontal16Symmetric() +
             const PagePadding.vertical8Symmetric(),
         border: ProductTextFieldDecoration.standardBorder(context),
         enabledBorder: ProductTextFieldDecoration.standardBorder(context),
         focusedBorder: ProductTextFieldDecoration.focusedBorderStyle(context),
         filled: true,
         counter: const SizedBox(),
       );
}

final class CustomTimeFieldDecoration extends InputDecoration {
  CustomTimeFieldDecoration({
    required BuildContext context,
    String? hint,
    IconData? prefixIcon,
  }) : super(
         prefixIcon: Icon(prefixIcon),
         hintText: hint,
         contentPadding: const PagePadding.horizontal16Symmetric(),
         border: ProductTextFieldDecoration.thickerStandardBorder(context),
         enabledBorder: ProductTextFieldDecoration.thickerStandardBorder(
           context,
         ),
         focusedBorder: ProductTextFieldDecoration.thickerStandardBorder(
           context,
         ),
       );
}

final class CustomDateTimeFieldDecoration extends InputDecoration {
  CustomDateTimeFieldDecoration({
    required BuildContext context,
    String? hint,
    IconData? suffixIcon,
  }) : super(
         suffixIcon: Icon(suffixIcon),
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
       );
}

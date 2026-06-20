import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/app_colors.dart';

@immutable
class CustomButtonStyle extends ButtonStyle {
  const CustomButtonStyle._();

  static ButtonStyle get bold {
    return OutlinedButton.styleFrom(
      padding: const PagePadding.verticalSymmetric(),
      side: const BorderSide(
        color: AppColors.navy,
        width: 3,
      ),
    );
  }

  static ButtonStyle get normal {
    return ElevatedButton.styleFrom(
      padding: const PagePadding.verticalSymmetric(),
    );
  }

  static ButtonStyle get shrinkWrap {
    return ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      minimumSize: WidgetStateProperty.all(Size.zero),
    );
  }
}

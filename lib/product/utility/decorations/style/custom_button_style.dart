import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';

@immutable
class CustomButtonStyle extends ButtonStyle {
  const CustomButtonStyle._();

  static ButtonStyle get bold {
    return OutlinedButton.styleFrom(
      padding: const PagePadding.verticalSymmetric(),
      side: const BorderSide(
        color: ColorsCustom.sambacus,
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
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      minimumSize: MaterialStateProperty.all(Size.zero),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// more detail for look at
/// https://m3.material.io/styles/color/the-color-system/tokens
final class ColorCommon {
  ColorCommon(this.context);

  final BuildContext context;

  static const Color sameWhiteColor = ColorsCustom.white;
  static const Color linkColor = ColorsCustom.brandeisBlue;

  /// means [ThemeData].light == white
  Color get whiteAndBlackForTheme {
    return context.general.colorScheme.onSurface;
  }

  /// means [ThemeData].light == black
  Color get blackAndWhiteForTheme {
    return context.general.colorScheme.surface;
  }
}

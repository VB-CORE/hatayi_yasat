import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';

final class ApplicationTheme {
  ApplicationTheme.build(BuildContext context) {
    final textTheme = context.general.textTheme;
    final theme = ThemeData.light(useMaterial3: true);

    themeData = theme.copyWith(
      textTheme: GoogleFonts.montserratTextTheme(textTheme),
      colorScheme: theme.colorScheme.copyWith(
        onError: ColorsCustom.braziliante,
        primary: ColorsCustom.sambacus,
      ),
      listTileTheme: const ListTileThemeData(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.black,
      ),
    );
  }
  late final ThemeData themeData;

  static double maxWeight = 1000;
}

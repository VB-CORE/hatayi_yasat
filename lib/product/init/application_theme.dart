import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';

final class ApplicationTheme {
  ApplicationTheme.build(BuildContext context) {
    final textTheme = context.general.textTheme;
    final theme = ThemeData.light(useMaterial3: true);

    themeData = theme.copyWith(
      cardTheme: const CardTheme(
        elevation: 2,
        color: ColorsCustom.white,
        shape: RoundedRectangleBorder(
          borderRadius: CustomRadius.medium,
        ),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: ColorsCustom.white,
        backgroundColor: ColorsCustom.white,
        titleTextStyle: textTheme.titleLarge?.copyWith(),
        iconTheme: const IconThemeData(
          color: ColorsCustom.white,
        ),
      ),
      textTheme: GoogleFonts.montserratTextTheme(textTheme).apply(
        displayColor: ColorsCustom.sambacus,
      ),
      colorScheme: theme.colorScheme.copyWith(
        primary: ColorsCustom.sambacus,
        secondary: ColorsCustom.white,
        onPrimaryContainer: ColorsCustom.lightGray,
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

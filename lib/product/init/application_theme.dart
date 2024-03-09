import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

final class ApplicationTheme {
  ApplicationTheme.build(BuildContext context) {
    final textTheme = context.general.textTheme;
    final theme = ThemeData.light(useMaterial3: true);

    themeData = theme.copyWith(
      dialogBackgroundColor: ColorsCustom.white,
      scaffoldBackgroundColor: ColorsCustom.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: ColorsCustom.sambacus,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: ColorsCustom.sambacus,
        ),
      ),
      cardTheme: const CardTheme(
        elevation: 2,
        color: ColorsCustom.white,
        shape: RoundedRectangleBorder(
          borderRadius: CustomRadius.medium,
        ),
      ),
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        foregroundColor: ColorsCustom.white,
        backgroundColor: ColorsCustom.white,
        titleTextStyle: textTheme.titleLarge?.copyWith(),
        iconTheme: const IconThemeData(
          color: ColorsCustom.sambacus,
        ),
      ),
      textTheme: GoogleFonts.montserratTextTheme(textTheme).apply(
        displayColor: ColorsCustom.sambacus,
      ),
      colorScheme: theme.colorScheme.copyWith(
        primary: ColorsCustom.sambacus,
        secondary: ColorsCustom.white,
        onPrimaryContainer: ColorsCustom.lightGray,
        error: ColorsCustom.imperilRead,
        primaryContainer: ColorsCustom.braziliante,
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
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorsCustom.black,
        contentTextStyle: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorsCustom.white,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thickness: MaterialStatePropertyAll(AppConstants.kOne.toDouble()),
      ),
    );
  }
  late final ThemeData themeData;

  static double maxWeight = 1000;
}

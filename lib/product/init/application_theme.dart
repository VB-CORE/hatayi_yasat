import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

final class ApplicationTheme {
  ApplicationTheme.build(BuildContext context) {
    // final textTheme = context.general.textTheme;
    final theme = ThemeData.light(useMaterial3: true);
    final textTheme = theme.textTheme;
    themeData = theme.copyWith(
      timePickerTheme: const TimePickerThemeData(
        hourMinuteTextColor: Colors.black,
        hourMinuteColor: ColorsCustom.softGray,
        dayPeriodColor: Colors.black,
        dialHandColor: Colors.black,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: ColorsCustom.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsCustom.white,
      ),
      scaffoldBackgroundColor: ColorsCustom.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: ColorsCustom.sambacus,
        backgroundColor: ColorsCustom.white,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: ColorsCustom.sambacus,
        ),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        color: ColorsCustom.white,
        shape: RoundedRectangleBorder(
          borderRadius: CustomRadius.medium,
        ),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        foregroundColor: ColorsCustom.white,
        backgroundColor: ColorsCustom.white,
        titleTextStyle: TextStyle(
          color: ColorsCustom.sambacus,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: ColorsCustom.sambacus,
        ),
      ),
      textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(),
      colorScheme: theme.colorScheme.copyWith(
        primary: ColorsCustom.sambacus,
        secondary: ColorsCustom.white,
        onPrimaryContainer: ColorsCustom.lightGray,
        onPrimaryFixed: ColorsCustom.gray,
        error: ColorsCustom.imperilRead,
        primaryContainer: ColorsCustom.braziliante,
        onTertiaryContainer: ColorsCustom.green,
        onSecondaryContainer: ColorsCustom.royalPeacock,
        onSecondaryFixed: ColorsCustom.warmGrey,
        onPrimaryFixedVariant: ColorsCustom.darkGray,
        onTertiaryFixedVariant: ColorsCustom.underlinePurple,
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
        thickness: WidgetStatePropertyAll(AppConstants.kOne.toDouble()),
      ),
    );
  }
  late final ThemeData themeData;

  static double maxWeight = 1000;
}

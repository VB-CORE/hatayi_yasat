import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

final class ApplicationTheme {
  ApplicationTheme.build()
    : lightThemeData = _buildTheme(Brightness.light),
      darkThemeData = _buildTheme(Brightness.dark);

  static const Color _darkSurface = Color(0xFF0F172A);
  static const Color _darkSurfaceElevated = Color(0xFF172033);
  static const Color _darkBorder = Color(0xFF334155);
  static const Color _darkMuted = Color(0xFF94A3B8);
  static const Color _darkText = Color(0xFFF8FAFC);
  static const Color _darkSuccess = Color(0xFF14532D);
  static const Color _darkSuccessText = Color(0xFF86EFAC);
  static const Color _darkPrimary = Color(0xFF7DD3FC);
  static const Color _darkAccent = Color(0xFFC4B5FD);

  final ThemeData lightThemeData;
  final ThemeData darkThemeData;

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final theme = isDark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);
    final colorScheme = _buildColorScheme(theme.colorScheme, isDark: isDark);
    final textTheme = GoogleFonts.robotoTextTheme(theme.textTheme).apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return theme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      timePickerTheme: TimePickerThemeData(
        backgroundColor: colorScheme.secondary,
        hourMinuteTextColor: colorScheme.onSurface,
        hourMinuteColor: colorScheme.onPrimaryFixed,
        dayPeriodColor: colorScheme.onPrimaryFixed,
        dialHandColor: colorScheme.primary,
        dialBackgroundColor: colorScheme.onPrimaryFixed,
        entryModeIconColor: colorScheme.primary,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.secondary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.secondary,
        modalBackgroundColor: colorScheme.secondary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: colorScheme.primary,
        backgroundColor: colorScheme.secondary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colorScheme.primary,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: CustomRadius.medium,
        ),
      ),
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        backgroundColor: colorScheme.surface,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
        ),
      ),
      textTheme: textTheme,
      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        iconColor: colorScheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.onPrimaryFixed,
        hintStyle: textTheme.titleSmall?.copyWith(
          color: colorScheme.onSecondaryFixed,
        ),
        enabledBorder: _inputBorder(colorScheme.onPrimaryContainer),
        focusedBorder: _inputBorder(colorScheme.primary),
        border: _inputBorder(colorScheme.onPrimaryContainer),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? _darkSurfaceElevated : ColorsCustom.sambacus,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? _darkText : ColorsCustom.white,
        ),
        actionTextColor: colorScheme.primary,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.secondary,
        textStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.onPrimaryContainer,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thickness: WidgetStatePropertyAll(AppConstants.kOne.toDouble()),
      ),
    );
  }

  static ColorScheme _buildColorScheme(
    ColorScheme currentScheme, {
    required bool isDark,
  }) {
    return currentScheme.copyWith(
      primary: isDark ? _darkPrimary : ColorsCustom.sambacus,
      secondary: isDark ? _darkSurfaceElevated : ColorsCustom.white,
      surface: isDark ? _darkSurface : ColorsCustom.white,
      onSurface: isDark ? _darkText : ColorsCustom.sambacus,
      onPrimary: isDark ? ColorsCustom.sambacus : ColorsCustom.white,
      onPrimaryContainer: isDark ? _darkBorder : ColorsCustom.lightGray,
      onPrimaryFixed: isDark ? _darkSurfaceElevated : ColorsCustom.gray,
      error: ColorsCustom.imperilRead,
      primaryContainer: isDark ? _darkSuccess : ColorsCustom.braziliante,
      onTertiaryContainer: isDark ? _darkSuccessText : ColorsCustom.green,
      onSecondaryContainer: isDark ? _darkPrimary : ColorsCustom.royalPeacock,
      onSecondaryFixed: isDark ? _darkMuted : ColorsCustom.warmGrey,
      onPrimaryFixedVariant: isDark ? _darkText : ColorsCustom.darkGray,
      onTertiaryFixedVariant: isDark
          ? _darkAccent
          : ColorsCustom.underlinePurple,
    );
  }

  static OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: color),
    );
  }

  static double maxWeight = 1000;
}

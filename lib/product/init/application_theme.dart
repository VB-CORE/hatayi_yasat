import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

final class ApplicationTheme {
  ApplicationTheme.build()
    : lightThemeData = _buildTheme(Brightness.light),
      darkThemeData = _buildTheme(Brightness.dark);

  // V2 mozaik dark surfaces — derived from navy primary so the dark mode
  // reads as the same brand world rather than a generic slate.
  static const Color _darkSurface = Color(0xFF08182A);
  static const Color _darkSurfaceElevated = Color(0xFF0B2138);
  static const Color _darkBorder = Color(0xFF2E4D70);
  static const Color _darkMuted = Color(0xFF94A4B9);
  static const Color _darkText = Color(0xFFF7F9FB);
  static const Color _darkSuccess = Color(0xFF385819);
  static const Color _darkPrimary = Color(0xFF8FD4DF);
  static const Color _darkAccent = Color(0xFFEE7263);
  // Memorial / pending gold tone for V2 mozaik dark mode.
  static const Color _darkTertiary = Color(0xFFDDB74B);
  static const Color _darkTertiaryContainer = Color(0xFF3A2E10);

  final ThemeData lightThemeData;
  final ThemeData darkThemeData;

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final theme = isDark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);
    final colorScheme = _buildColorScheme(theme.colorScheme, isDark: isDark);
    final textTheme = GoogleFonts.plusJakartaSansTextTheme(theme.textTheme)
        .apply(
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
          fontWeight: FontWeight.w700,
          letterSpacing: -0.1,
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
      primary: isDark ? _darkPrimary : ColorsCustom.navy,
      secondary: isDark ? _darkSurfaceElevated : ColorsCustom.white,
      surface: isDark ? _darkSurface : ColorsCustom.white,
      onSurface: isDark ? _darkText : ColorsCustom.ink900,
      onPrimary: isDark ? ColorsCustom.navy : ColorsCustom.white,
      onPrimaryContainer: isDark ? _darkBorder : ColorsCustom.ink100,
      onPrimaryFixed: isDark ? _darkSurfaceElevated : ColorsCustom.bgCool,
      error: ColorsCustom.coral,
      primaryContainer: isDark ? _darkSuccess : ColorsCustom.olive,
      onSecondaryContainer: isDark ? _darkPrimary : ColorsCustom.teal,
      onSecondaryFixed: isDark ? _darkMuted : ColorsCustom.ink400,
      onPrimaryFixedVariant: isDark ? _darkText : ColorsCustom.ink600,
      onTertiaryFixedVariant: isDark ? _darkAccent : ColorsCustom.coral,
      // Memorial / pending gold role — used by hatıralar surfaces and the
      // merchant application "in review" state.
      tertiary: isDark ? _darkTertiary : ColorsCustom.gold,
      tertiaryContainer: isDark ? _darkTertiaryContainer : ColorsCustom.gold50,
      onTertiary: isDark ? ColorsCustom.navy : ColorsCustom.white,
      onTertiaryContainer: isDark ? ColorsCustom.gold200 : ColorsCustom.gold600,
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

/// V2 mozaik typography helpers.
///
/// Body styles already come from `Theme.of(context).textTheme` (Plus Jakarta
/// Sans). Use [V2Typography.display] for the editorial DM Serif Display
/// headlines used on splash, hero sections, and brand surfaces. Use
/// [V2Typography.eyebrow] for the small uppercase signature label that
/// precedes display headings throughout V2.
final class V2Typography {
  const V2Typography._();

  /// Editorial display style — DM Serif Display. Pair with a tight letter
  /// spacing and the navy ink. Used for splash, place hero, brand artboards.
  static TextStyle display({
    double fontSize = 32,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
  }) => GoogleFonts.dmSerifDisplay(
    fontSize: fontSize,
    height: 1.05,
    letterSpacing: -0.02 * fontSize,
    color: color,
    fontStyle: fontStyle,
  );

  /// Small uppercase signature label that precedes display headings.
  /// Default coral mirrors the V2 mozaik accent.
  static TextStyle eyebrow({
    double fontSize = 11,
    Color color = ColorsCustom.coral,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: fontSize,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.16 * fontSize,
    color: color,
  );

  /// Bold meta caption used for status pills, badge text, and dense rows
  /// (rating count, distance, attendee count). Slightly tighter tracking and
  /// smaller scale than [eyebrow] without uppercase transformation.
  static TextStyle label({
    double fontSize = 12,
    Color? color,
    FontWeight fontWeight = FontWeight.w800,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: 0.04 * fontSize,
    color: color,
  );
}

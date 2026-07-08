import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';

final class ApplicationTheme {
  ApplicationTheme.build() : themeData = buildAppTheme();

  final ThemeData themeData;

  static ThemeData buildAppTheme() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      primary: AppColors.navy,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.surface,
      onPrimaryContainer: AppColors.navy,
      secondary: AppColors.teal,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.surface,
      onSecondaryContainer: AppColors.teal,
      tertiary: AppColors.coral,
      onTertiary: AppColors.white,
      tertiaryContainer: AppColors.surface,
      onTertiaryContainer: AppColors.coral,
      error: AppColors.coral,
      onError: AppColors.white,
      errorContainer: AppColors.surface,
      onErrorContainer: AppColors.coral,
      surface: AppColors.bg,
      onSurface: AppColors.surface,
      onSurfaceVariant: AppColors.ink400,
      surfaceContainerHighest: AppColors.bgDeep,
      outline: AppColors.ink100,
      outlineVariant: AppColors.ink50,
      inverseSurface: AppColors.navy,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.coral,
      surfaceTint: Colors.transparent,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.bg,
      fontFamily: 'PlusJakartaSans',
      splashFactory: NoSplash.splashFactory,
      dividerColor: AppColors.ink50,
      textTheme: const TextTheme(
        displayLarge: AppText.displayXl,
        displayMedium: AppText.displayLg,
        displaySmall: AppText.displayMd,
        headlineLarge: AppText.displaySm,
        headlineMedium: AppText.titleLg,
        headlineSmall: AppText.title,
        titleLarge: AppText.titleLg,
        titleMedium: AppText.title,
        titleSmall: AppText.label,
        bodyLarge: AppText.bodyLg,
        bodyMedium: AppText.body,
        bodySmall: AppText.bodySm,
        labelLarge: AppText.label,
        labelMedium: AppText.caption,
        labelSmall: AppText.micro,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.coral,
        foregroundColor: AppColors.white,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.bg,
        textStyle: AppText.body.copyWith(
          color: AppColors.navy,
        ),
        shape: RoundedRectangleBorder(borderRadius: .circular(AppRadius.md)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        labelStyle: AppText.body.copyWith(color: AppColors.ink600),
        hintStyle: AppText.body.copyWith(color: AppColors.ink600),
        enabledBorder: _inputBorder(AppColors.ink100),
        focusedBorder: _inputBorder(AppColors.navy),
        errorBorder: _inputBorder(AppColors.coral),
        focusedErrorBorder: _inputBorder(AppColors.coral600),
        border: _inputBorder(AppColors.ink100),
        disabledBorder: _inputBorder(AppColors.ink50),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.surface,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: AppText.title.copyWith(
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: AppColors.surface,
        surfaceTintColor: AppColors.ink300,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: AppText.body.copyWith(
          color: AppColors.navy,
          fontWeight: FontWeight.w600,
        ),
        iconColor: AppColors.navy,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: .circular(AppRadius.md)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: .circular(AppRadius.md)),
        ),
      ),

      expansionTileTheme: const ExpansionTileThemeData(
        iconColor: AppColors.navy,
        collapsedIconColor: AppColors.navy,
        backgroundColor: AppColors.surface,
        collapsedBackgroundColor: AppColors.surface,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.card,
          side: const BorderSide(color: AppColors.ink100),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.coral;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: AppColors.coral, width: 2),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.card,
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: color),
    );
  }
}

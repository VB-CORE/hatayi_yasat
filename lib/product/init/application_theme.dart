import 'package:flutter/material.dart';
import 'package:vbaseproject/product/items/colors_custom.dart';

final class ApplicationTheme {
  ApplicationTheme.build() {
    final theme = ThemeData.light(useMaterial3: true);
    themeData = theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        onError: ColorsCustom.braziliante,
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

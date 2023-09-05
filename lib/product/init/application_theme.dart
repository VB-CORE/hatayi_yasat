import 'package:flutter/material.dart';

final class ApplicationTheme {
  ApplicationTheme.build() {
    themeData = ThemeData.light(useMaterial3: true).copyWith(
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
}

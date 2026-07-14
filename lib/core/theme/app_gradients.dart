import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

abstract final class AppGradients {
  /// Kapak görseli olmayan kartlar/başlıklar için fallback gradient çiftleri.
  static const List<List<Color>> coverFallbacks = [
    [AppColors.coral300, AppColors.coral700],
    [AppColors.teal300, AppColors.navy500],
    [AppColors.olive300, AppColors.olive700],
    [AppColors.navy300, AppColors.teal600],
  ];
}

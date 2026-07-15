import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

/// Material [ColorScheme] rolleriyle birebir örtüşmeyen marka tonları için
/// `context.appColors.*` erişimi.
extension AppContextColors on BuildContext {
  AppColorTokens get appColors => const AppColorTokens();
}

@immutable
final class AppColorTokens {
  const AppColorTokens();

  Color get mutedText => AppColors.navy300;
  Color get mutedTextAlt => AppColors.navy400;
  Color get softBorder => AppColors.ink200;
  Color get cardSurface => AppColors.surface;
  Color get openBadge => AppColors.olive600;
  Color get closedBadge => AppColors.navy400;
  Color get darkSurface => AppColors.navy700;
  Color get strongText => AppColors.navy700;
  Color get softTextOnDark => AppColors.navy100;
}

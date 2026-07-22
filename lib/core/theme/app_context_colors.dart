import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

/// Material [ColorScheme] rolleriyle birebir örtüşmeyen marka tonları için
/// `context.appColors.*` erişimi. İsimler `AppColors` sabitleriyle bire bir
/// aynı — aynı ton farklı isimler altında tekrar tekrar eklenmesin diye.
extension AppContextColors on BuildContext {
  AppColorTokens get appColors => const AppColorTokens();
}

@immutable
final class AppColorTokens {
  const AppColorTokens();

  Color get navy100 => AppColors.navy100;
  Color get navy300 => AppColors.navy300;
  Color get navy400 => AppColors.navy400;
  Color get navy700 => AppColors.navy700;
  Color get navy900 => AppColors.navy900;
  Color get ink200 => AppColors.ink200;
  Color get olive600 => AppColors.olive600;
  Color get gold300 => AppColors.gold300;

  /// `colorScheme.surface`'tan farklıdır (o `AppColors.bg`'ye eşlenir);
  /// bu, `AppColors.surface`'ın (düz beyaz) kendisidir.
  Color get surface => AppColors.surface;
}

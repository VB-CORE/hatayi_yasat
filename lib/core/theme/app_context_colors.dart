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

  Color get navy => AppColors.navy;
  Color get navy50 => AppColors.navy50;
  Color get navy100 => AppColors.navy100;
  Color get navy300 => AppColors.navy300;
  Color get navy400 => AppColors.navy400;
  Color get navy500 => AppColors.navy500;
  Color get navy700 => AppColors.navy700;
  Color get navy800 => AppColors.navy800;
  Color get navy900 => AppColors.navy900;
  Color get coral => AppColors.coral;
  Color get coral50 => AppColors.coral50;
  Color get coral100 => AppColors.coral100;
  Color get coral500 => AppColors.coral500;
  Color get coral600 => AppColors.coral600;
  Color get ink25 => AppColors.ink25;
  Color get ink100 => AppColors.ink100;
  Color get ink200 => AppColors.ink200;
  Color get ink300 => AppColors.ink300;
  Color get ink400 => AppColors.ink400;
  Color get ink500 => AppColors.ink500;
  Color get ink600 => AppColors.ink600;
  Color get ink800 => AppColors.ink800;
  Color get olive => AppColors.olive;
  Color get olive50 => AppColors.olive50;
  Color get olive600 => AppColors.olive600;
  Color get gold => AppColors.gold;
  Color get gold200 => AppColors.gold200;
  Color get gold300 => AppColors.gold300;
  Color get teal => AppColors.teal;
  Color get teal50 => AppColors.teal50;
  Color get teal300 => AppColors.teal300;
  Color get white => AppColors.white;

  /// `colorScheme.surface`'tan farklıdır (o `AppColors.bg`'ye eşlenir);
  /// bu, `AppColors.surface`'ın (düz beyaz) kendisidir.
  Color get surface => AppColors.surface;
}

import 'package:flutter/widgets.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

abstract final class AppText {
  static const _serif = 'DMSerifDisplay';
  static const _sans = 'PlusJakartaSans';

  static const displayXl = TextStyle(
    fontFamily: _serif,
    fontSize: 42,
    height: 1.06,
    letterSpacing: -0.8,
    color: AppColors.navy,
  );
  static const displayLg = TextStyle(
    fontFamily: _serif,
    fontSize: 30,
    height: 1.12,
    letterSpacing: -0.3,
    color: AppColors.navy,
  );
  static const displayMd = TextStyle(
    fontFamily: _serif,
    fontSize: 26,
    height: 1.10,
    letterSpacing: -0.3,
    color: AppColors.navy,
  );
  static const displaySm = TextStyle(
    fontFamily: _serif,
    fontSize: 21,
    height: 1.10,
    letterSpacing: -0.2,
    color: AppColors.navy,
  );
  static const titleLg = TextStyle(
    fontFamily: _serif,
    fontSize: 19,
    height: 1.15,
    letterSpacing: -0.2,
    color: AppColors.navy,
  );
  static const title = TextStyle(
    fontFamily: _serif,
    fontSize: 17,
    height: 1.15,
    letterSpacing: -0.2,
    color: AppColors.navy,
  );

  static const bodyLg = TextStyle(
    fontFamily: _sans,
    fontSize: 14.5,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: AppColors.ink900,
  );
  static const body = TextStyle(
    fontFamily: _sans,
    fontSize: 13,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: AppColors.ink700,
  );
  static const bodySm = TextStyle(
    fontFamily: _sans,
    fontSize: 12,
    height: 1.45,
    fontWeight: FontWeight.w500,
    color: AppColors.ink600,
  );
  static const label = TextStyle(
    fontFamily: _sans,
    fontSize: 13.5,
    height: 1.2,
    fontWeight: FontWeight.w800,
    color: AppColors.ink900,
  );
  static const caption = TextStyle(
    fontFamily: _sans,
    fontSize: 11.5,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.ink500,
  );
  static const micro = TextStyle(
    fontFamily: _sans,
    fontSize: 10.5,
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: AppColors.ink400,
  );

  static const eyebrow = TextStyle(
    fontFamily: _sans,
    fontSize: 11,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.8,
    color: AppColors.coral,
  );
}

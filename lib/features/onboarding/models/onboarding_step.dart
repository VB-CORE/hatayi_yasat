import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

final class OnboardingStep {
  const OnboardingStep({
    required this.category,
    required this.title,
    required this.description,
    required this.chips,
    required this.color,
    required this.icon,
    required this.indicator,
  });

  final String category;
  final String title;
  final String description;
  final List<String> chips;
  final Color color;
  final IconData icon;
  final IconData indicator;

  static const List<OnboardingStep> pages = [
    OnboardingStep(
      category: LocaleKeys.onboarding_pages_0_category,
      title: LocaleKeys.onboarding_pages_0_title,
      description: LocaleKeys.onboarding_pages_0_desc,
      chips: [
        LocaleKeys.onboarding_pages_0_chips_0,
        LocaleKeys.onboarding_pages_0_chips_1,
        LocaleKeys.onboarding_pages_0_chips_2,
        LocaleKeys.onboarding_pages_0_chips_3,
      ],
      color: AppColors.coral,
      icon: AppIcons.storeFilled,
      indicator: AppIcons.storeFilled,
    ),
    OnboardingStep(
      category: LocaleKeys.onboarding_pages_1_category,
      title: LocaleKeys.onboarding_pages_1_title,
      description: LocaleKeys.onboarding_pages_1_desc,
      chips: [
        LocaleKeys.onboarding_pages_1_chips_0,
        LocaleKeys.onboarding_pages_1_chips_1,
        LocaleKeys.onboarding_pages_1_chips_2,
        LocaleKeys.onboarding_pages_1_chips_3,
      ],
      color: AppColors.teal,
      icon: AppIcons.star,
      indicator: AppIcons.star,
    ),
    OnboardingStep(
      category: LocaleKeys.onboarding_pages_2_category,
      title: LocaleKeys.onboarding_pages_2_title,
      description: LocaleKeys.onboarding_pages_2_desc,
      chips: [
        LocaleKeys.onboarding_pages_2_chips_0,
        LocaleKeys.onboarding_pages_2_chips_1,
        LocaleKeys.onboarding_pages_2_chips_2,
        LocaleKeys.onboarding_pages_2_chips_3,
      ],
      color: AppColors.gold,
      icon: AppIcons.groups,
      indicator: AppIcons.groups,
    ),
    OnboardingStep(
      category: LocaleKeys.onboarding_pages_3_category,
      title: LocaleKeys.onboarding_pages_3_title,
      description: LocaleKeys.onboarding_pages_3_desc,
      chips: [
        LocaleKeys.onboarding_pages_3_chips_0,
        LocaleKeys.onboarding_pages_3_chips_1,
        LocaleKeys.onboarding_pages_3_chips_2,
        LocaleKeys.onboarding_pages_3_chips_3,
      ],
      color: AppColors.olive,
      icon: AppIcons.discount,
      indicator: AppIcons.discount,
    ),
  ];
}

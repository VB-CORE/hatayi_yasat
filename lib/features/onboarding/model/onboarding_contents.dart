import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/onboarding/model/onboarding_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

@immutable
final class OnboardingContents {
  const OnboardingContents._();

  static List<OnboardingModel> create() {
    return [
      OnboardingModel(
        category: LocaleKeys.onboarding_pages_0_category.tr(),
        title: LocaleKeys.onboarding_pages_0_title.tr(),
        desc: LocaleKeys.onboarding_pages_0_desc.tr(),
        chips: [
          LocaleKeys.onboarding_pages_0_chips_0.tr(),
          LocaleKeys.onboarding_pages_0_chips_1.tr(),
          LocaleKeys.onboarding_pages_0_chips_2.tr(),
          LocaleKeys.onboarding_pages_0_chips_3.tr(),
        ],
        color: AppColors.coral,
        icon: AppIcons.storeFilled,
      ),
      OnboardingModel(
        category: LocaleKeys.onboarding_pages_1_category.tr(),
        title: LocaleKeys.onboarding_pages_1_title.tr(),
        desc: LocaleKeys.onboarding_pages_1_desc.tr(),
        chips: [
          LocaleKeys.onboarding_pages_1_chips_0.tr(),
          LocaleKeys.onboarding_pages_1_chips_1.tr(),
          LocaleKeys.onboarding_pages_1_chips_2.tr(),
          LocaleKeys.onboarding_pages_1_chips_3.tr(),
        ],
        color: AppColors.gold,
        icon: AppIcons.star,
      ),
      OnboardingModel(
        category: LocaleKeys.onboarding_pages_2_category.tr(),
        title: LocaleKeys.onboarding_pages_2_title.tr(),
        desc: LocaleKeys.onboarding_pages_2_desc.tr(),
        chips: [
          LocaleKeys.onboarding_pages_2_chips_0.tr(),
          LocaleKeys.onboarding_pages_2_chips_1.tr(),
          LocaleKeys.onboarding_pages_2_chips_2.tr(),
          LocaleKeys.onboarding_pages_2_chips_3.tr(),
        ],
        color: AppColors.teal,
        icon: AppIcons.groups,
      ),
      OnboardingModel(
        category: LocaleKeys.onboarding_pages_3_category.tr(),
        title: LocaleKeys.onboarding_pages_3_title.tr(),
        desc: LocaleKeys.onboarding_pages_3_desc.tr(),
        chips: [
          LocaleKeys.onboarding_pages_3_chips_0.tr(),
          LocaleKeys.onboarding_pages_3_chips_1.tr(),
          LocaleKeys.onboarding_pages_3_chips_2.tr(),
          LocaleKeys.onboarding_pages_3_chips_3.tr(),
        ],
        color: AppColors.olive,
        icon: AppIcons.discount,
      ),
    ];
  }
}

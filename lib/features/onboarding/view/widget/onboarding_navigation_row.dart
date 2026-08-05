import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/onboarding/view_model/onboarding_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/general/general_button.dart';

final class OnboardingNavigationRow extends StatelessWidget {
  const OnboardingNavigationRow({
    required this.state,
    required this.onNextPressed,
    required this.onBackPressed,
    super.key,
  });

  final OnboardingState state;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    if (state.isWelcomePage) {
      return SizedBox(
        width: double.infinity,
        child: GeneralButtonV2.active(
          action: onNextPressed,
          label: LocaleKeys.onboarding_button_start.tr(),
          icon: AppIcons.arrowForward,
          iconAlignment: IconAlignment.end,
        ),
      );
    }

    return Row(
      children: [
        InkWell(
          onTap: onBackPressed,
          child: SizedBox(
            width: AppIconSizes.xLarge,
            height: AppIconSizes.xLarge,
            child: Icon(
              AppIcons.arrowBack,
              color: context.appColors.navy500,
              size: AppIconSizes.medium,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: GeneralButtonV2.active(
            action: onNextPressed,
            label: state.isLastPage
                ? LocaleKeys.onboarding_button_complete.tr()
                : LocaleKeys.onboarding_button_next.tr(),
            iconAlignment: IconAlignment.end,
          ),
        ),
      ],
    );
  }
}

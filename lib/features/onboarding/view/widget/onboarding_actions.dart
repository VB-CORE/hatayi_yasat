part of '../onboarding_view.dart';

final class OnboardingActions extends StatelessWidget {
  const OnboardingActions({
    required this.state,
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final OnboardingState state;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    if (state.isWelcome) {
      return SizedBox(
        width: double.infinity,
        child: GeneralButtonV2.active(
          action: onNext,
          label: LocaleKeys.onboarding_button_start.tr(),
          icon: AppIcons.arrowForward,
          iconAlignment: IconAlignment.end,
        ),
      );
    }

    return Row(
      children: [
        InkWell(
          onTap: onBack,
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
            action: onNext,
            label: state.isLast
                ? LocaleKeys.onboarding_button_complete.tr()
                : LocaleKeys.onboarding_button_next.tr(),
            iconAlignment: IconAlignment.end,
          ),
        ),
      ],
    );
  }
}

part of '../onboarding_view.dart';

final class OnboardingWelcomeView extends StatelessWidget {
  const OnboardingWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        spacing: WidgetSizes.spacingL,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            child: CustomShimmer(
              duration: const Duration(seconds: 5),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.appColors.navy700.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                ),
                child: Padding(
                  padding: const PagePadding.allVeryLow(),
                  child: Assets.icons.icAppTransparent.image(
                    height: context.sized.dynamicWidth(.25),
                  ),
                ),
              ),
            ),
          ),
          Text(
            LocaleKeys.project_name.tr(),
            style: AppText.displayLg.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.navy100,
            ),
          ),
          SizedBox(
            width: context.sized.dynamicWidth(.75),
            child: Text(
              LocaleKeys.onboarding_welcome_desc.tr(),
              style: AppText.bodyLg.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appColors.ink300,
              ),
            ),
          ),
          SizedBox(height: context.sized.dynamicHeight(.12)),
        ],
      ),
    );
  }
}

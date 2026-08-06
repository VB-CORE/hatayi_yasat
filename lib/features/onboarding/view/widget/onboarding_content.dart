part of '../onboarding_view.dart';

final class OnboardingContentView extends StatelessWidget {
  const OnboardingContentView({required this.model, super.key});

  final OnboardingStep model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: WidgetSizes.spacingL,
      children: [
        Text(
          model.category.tr(),
          style: AppText.bodyLg.copyWith(
            fontWeight: FontWeight.bold,
            color: model.color,
          ),
        ),
        Text(
          model.title.tr(),
          style: AppText.displayLg.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.navy,
          ),
        ),
        Text(
          model.description.tr(),
          style: AppText.bodyLg.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.ink500,
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            chipTheme: ChipThemeData(
              labelStyle: AppText.bodySm.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appColors.navy500,
              ),
              backgroundColor: context.appColors.ink25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                side: BorderSide(color: context.appColors.ink200),
              ),
            ),
          ),
          child: Wrap(
            spacing: AppSpacing.xxs,
            runSpacing: AppSpacing.xs,
            children: model.chips
                .map(
                  (chipText) => Chip(
                    label: Text(chipText.tr()),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

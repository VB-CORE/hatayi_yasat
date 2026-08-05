import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/onboarding/model/onboarding_model.dart';

final class OnboardingCardContent extends StatelessWidget {
  const OnboardingCardContent({required this.model, super.key});

  final OnboardingModel? model;

  @override
  Widget build(BuildContext context) {
    if (model == null) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: WidgetSizes.spacingL,
      children: [
        Text(
          model!.category,
          style: AppText.bodyLg.copyWith(
            fontWeight: FontWeight.bold,
            color: model!.color,
          ),
        ),
        Text(
          model!.title,
          style: AppText.displayLg.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.navy,
          ),
        ),
        Text(
          model!.desc,
          style: AppText.bodyLg.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.ink500,
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            chipTheme: ChipThemeData(
              labelStyle: AppText.body.copyWith(
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
            runSpacing: AppSpacing.xxs,
            children: model!.chips
                .map((chipText) => Chip(label: Text(chipText)))
                .toList(),
          ),
        ),
      ],
    );
  }
}

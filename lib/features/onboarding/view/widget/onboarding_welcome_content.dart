import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/shimmer/shimmer.dart';

final class OnboardingWelcomeContent extends StatelessWidget {
  const OnboardingWelcomeContent({super.key});

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
          SizedBox(
            height: context.sized.dynamicHeight(.12),
          ),
        ],
      ),
    );
  }
}

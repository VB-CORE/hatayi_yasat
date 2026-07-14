import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';
import 'package:lifeclient/product/widget/general/title/general_body_title.dart';

final class MerchantStepIndicator extends StatelessWidget {
  const MerchantStepIndicator({
    required this.currentStep,
    required this.stepCount,
    required this.title,
    super.key,
    this.onClose,
  });

  final int currentStep;
  final int stepCount;
  final String title;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onClose,
                icon: const Icon(AppIcons.close),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralBodySmallTitle(
                      LocaleKeys.merchantApplication_headerLabel
                          .tr()
                          .toUpperCase(),
                      color: AppColors.coral,
                    ),
                    GeneralBodyTitle(title),
                  ],
                ),
              ),
              GeneralBodySmallTitle(
                '${currentStep + 1}/$stepCount',
                color: AppColors.ink400,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const EmptyBox.smallHeight(),

          Row(
            children: [
              for (var i = 0; i < stepCount; i++) ...[
                if (i != 0) const SizedBox(width: WidgetSizes.spacingXs),
                Expanded(
                  child: AnimatedContainer(
                    duration: DurationConstant.durationLow,
                    height: WidgetSizes.spacingXxs,
                    decoration: BoxDecoration(
                      color: i <= currentStep
                          ? AppColors.coral
                          : AppColors.ink100,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

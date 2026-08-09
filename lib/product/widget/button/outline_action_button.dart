import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

final class OutlineActionButton extends StatelessWidget {
  const OutlineActionButton({
    required this.labelKey,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String labelKey;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.appColors.ink100),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: WidgetSizes.spacingXxl5,
          ),
          child: Padding(
            padding: const PagePadding.horizontalLowSymmetric(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.xs,
              children: [
                Icon(
                  icon,
                  color: context.appColors.navy,
                  size: AppIconSizes.medium,
                ),
                Flexible(
                  child: GeneralBodySmallTitle(
                    labelKey.tr(),
                    maxLines: 1,
                    color: context.appColors.navy,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

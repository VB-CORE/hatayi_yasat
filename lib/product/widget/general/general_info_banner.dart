import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

/// Circle icon + short text info box on a soft neutral background.
@immutable
final class GeneralInfoBanner extends StatelessWidget {
  const GeneralInfoBanner({
    required this.message,
    this.icon = AppIcons.info,
    super.key,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalAllLow(),
      decoration: const BoxDecoration(
        color: AppColors.navy50,
        borderRadius: CustomRadius.medium,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppIconSizes.smallX,
            backgroundColor: AppColors.navy200,
            child: Icon(
              icon,
              size: AppIconSizes.xMedium,
              color: AppColors.navy50,
            ),
          ),
          const SizedBox(width: AppIconSizes.smallX),
          Expanded(
            child: Text(
              message,
              style: context.general.textTheme.bodySmall?.copyWith(
                color: AppColors.navy400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

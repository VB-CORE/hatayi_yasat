import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';

@immutable
final class ContentMenuItem {
  const ContentMenuItem({
    required this.icon,
    required this.label,
    this.subtitle,
    this.trailing,
    this.labelColor,
    this.showBadge = false,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final Color? labelColor;
  final bool showBadge;
  final bool showChevron;
  final VoidCallback? onTap;
}

final class ContentMenuItemTile extends StatelessWidget {
  const ContentMenuItemTile({
    required this.item,
    required this.iconColor,
    required this.iconBackgroundColor,
    super.key,
  });

  final ContentMenuItem item;
  final Color iconColor;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      item.icon,
      size: AppIconSizes.medium,
      color: iconColor,
    );

    return CustomBounceable(
      onTap: item.onTap,
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            padding: const PagePadding.allLow(),
            child: item.showBadge
                ? Badge(
                    backgroundColor: AppColors.coral,
                    smallSize: AppIconSizes.small,
                    child: icon,
                  )
                : icon,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: AppText.bodyLg.copyWith(color: item.labelColor),
                ),
                if (item.subtitle case final subtitle? when subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: AppConstants.kTwo,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bodySm.copyWith(color: AppColors.navy300),
                  ),
              ],
            ),
          ),
          ?item.trailing,
          if (item.showChevron)
            const Icon(
              AppIcons.rightSelect,
              size: AppIconSizes.medium,
              color: AppColors.navy300,
            ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/card/news/news_category_style.dart';

@immutable
final class NewsCategoryBadgeRow extends StatelessWidget {
  const NewsCategoryBadgeRow({required this.type, super.key});

  final String? type;

  @override
  Widget build(BuildContext context) {
    final categoryLabel = type.newsCategoryLabel;

    return Wrap(
      spacing: AppSpacing.xxs,
      children: [
        _NewsBadgeChip(
          icon: AppIcons.calendarFilled,
          label: LocaleKeys.newsFeed_badge.tr().toUpperCase(),
          backgroundColor: AppColors.navy800.withValues(alpha: .82),
        ),
        if (categoryLabel != null)
          _NewsBadgeChip(
            label: categoryLabel,
            backgroundColor: type.newsCategoryColor.withValues(alpha: .88),
          ),
      ],
    );
  }
}

final class _NewsBadgeChip extends StatelessWidget {
  const _NewsBadgeChip({
    required this.label,
    required this.backgroundColor,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xxs,
        children: [
          if (icon != null)
            Icon(icon, size: AppIconSizes.smallX, color: AppColors.white),
          Text(label, style: AppText.micro.copyWith(color: AppColors.white)),
        ],
      ),
    );
  }
}

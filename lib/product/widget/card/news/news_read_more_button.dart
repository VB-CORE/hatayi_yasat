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

@immutable
final class NewsReadMoreButton extends StatelessWidget {
  const NewsReadMoreButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding:
            const PagePadding.horizontalNormalSymmetric() +
            const PagePadding.verticalVeryLowSymmetric(),
        decoration: BoxDecoration(
          color: AppColors.bgDeep,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xxs,
          children: [
            Text(
              LocaleKeys.newsFeed_readMore.tr(),
              style: AppText.label.copyWith(color: AppColors.navy),
            ),
            const Icon(
              AppIcons.rightArrow,
              size: AppIconSizes.xMedium,
              color: AppColors.navy,
            ),
          ],
        ),
      ),
    );
  }
}

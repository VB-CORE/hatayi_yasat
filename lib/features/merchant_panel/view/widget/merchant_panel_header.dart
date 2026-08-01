import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/extension/store_etension.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/image/custom_image_with_view_dialog.dart';
import 'package:lifeclient/product/widget/pill/status_pill.dart';

final class MerchantPanelHeader extends StatelessWidget {
  const MerchantPanelHeader({required this.store, super.key});

  final StoreModel store;

  static const double _overlap = AppSpacing.xl;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top + kToolbarHeight;
    final mosaicHeight = topInset + AppSpacing.xl;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: mosaicHeight,
              width: double.infinity,
              child: const MosaicBackground(),
            ),
            const SizedBox(height: _overlap),
          ],
        ),
        Padding(
          padding: const PagePadding.horizontalNormalSymmetric(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.appColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.ink50),
              boxShadow: AppShadows.card,
            ),
            child: Padding(
              padding: const PagePadding.generalAllLow(),
              child: _MerchantPanelStoreInfo(store: store),
            ),
          ),
        ),
      ],
    );
  }
}

final class _MerchantPanelStoreInfo extends StatelessWidget {
  const _MerchantPanelStoreInfo({required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    final imageSize = context.sized.dynamicWidth(.14);
    final categoryName = store.category?.name;

    return Row(
      spacing: AppSpacing.sm,
      children: [
        if (store.hasImage)
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: CustomImageWithViewDialog(
              image: store.coverImage,
              height: imageSize,
              width: imageSize,
            ),
          )
        else
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              color: context.appColors.coral50,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              AppIcons.storeFilled,
              size: AppIconSizes.large,
              color: context.appColors.coral,
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.xxs,
            children: [
              Text(
                store.updatedName,
                maxLines: AppConstants.kTwo,
                overflow: TextOverflow.ellipsis,
                style: AppText.title.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.appColors.navy800,
                ),
              ),
              if (categoryName != null && categoryName.isNotEmpty)
                Text(
                  categoryName,
                  style: AppText.bodySm.copyWith(
                    color: context.appColors.navy500,
                  ),
                ),
              Row(
                spacing: AppSpacing.xxs,
                children: [
                  Icon(
                    AppIcons.star,
                    size: AppIconSizes.xMedium,
                    color: context.appColors.gold,
                  ),
                  Text(
                    store.averageRatingLabel,
                    style: AppText.label,
                  ),
                  Flexible(child: StatusPill(store: store)),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: context.appColors.olive50,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.xxs,
            children: [
              Icon(
                AppIcons.checkFilled,
                size: AppIconSizes.smallX,
                color: context.appColors.olive600,
              ),
              Text(
                LocaleKeys.merchantPanel_approvedBadge.tr(),
                style: AppText.micro.copyWith(
                  color: context.appColors.olive600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

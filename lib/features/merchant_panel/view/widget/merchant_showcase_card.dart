import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_module_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_type_extension.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';

final class MerchantShowcaseCard extends StatelessWidget {
  const MerchantShowcaseCard({required this.module, super.key});

  final MerchantShowcaseModuleModel module;

  @override
  Widget build(BuildContext context) {
    final imageUrl = module.imageUrl;
    final dateLabel = _dateLabel;

    return Container(
      margin: const PagePadding.verticalLowSymmetric(),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: context.appColors.ink200),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            SizedBox(
              width: double.infinity,
              height: context.sized.dynamicHeight(0.14),
              child: CustomNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
            ),
          Padding(
            padding: const PagePadding.generalAllLow(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xxs,
              children: [
                Row(
                  spacing: AppSpacing.xs,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: module.type.backgroundColor,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: AppSpacing.xxs,
                        children: [
                          Icon(
                            module.type.icon,
                            size: AppIconSizes.smallX,
                            color: module.type.color,
                          ),
                          Text(
                            module.type.label.tr(),
                            style: AppText.micro.copyWith(
                              color: module.type.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (dateLabel != null)
                      Flexible(
                        child: Text(
                          dateLabel,
                          maxLines: AppConstants.kOne,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.micro,
                        ),
                      ),
                  ],
                ),
                Text(module.title, style: AppText.title),
                Text(module.description, style: AppText.bodySm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? get _dateLabel {
    final start = module.startAt;
    final end = module.endAt;
    if (start == null && end == null) return null;
    if (start != null && end != null) {
      return '${start.shortDate} – ${end.shortDate}';
    }
    return (start ?? end)!.shortDate;
  }
}

import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_type_meta.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.model, required this.onTap, super.key});

  final AppNotificationModel model;
  final VoidCallback onTap;

  String get _content => model.type == AppNotificationType.link
      ? model.title ?? ''
      : model.body ?? '';

  @override
  Widget build(BuildContext context) {
    final type = model.type;
    if (type == null) return const SizedBox.shrink();

    final meta = NotificationTypeMeta.of(type);
    final content = _content.trim();
    final createdAt = model.createdAt;

    return CustomBounceable(
      onTap: onTap,
      child: Padding(
        padding:
            const PagePadding.horizontal16Symmetric() +
            const PagePadding.vertical12Symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.xxs,
          children: [
            Row(
              children: [
                Icon(
                  meta.icon,
                  size: AppIconSizes.xMedium,
                  color: AppColors.navy400,
                ),
                const EmptyBox.smallWidth(),
                Expanded(
                  child: GeneralContentSubTitle(
                    value: meta.label,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy400,
                  ),
                ),
                if (createdAt != null)
                  GeneralContentSmallTitle(
                    value: createdAt.hm,
                    color: AppColors.navy300,
                  ),
              ],
            ),
            if (content.isNotEmpty) GeneralContentSubTitle(value: content),
          ],
        ),
      ),
    );
  }
}

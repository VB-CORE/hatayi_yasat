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
  const NotificationTile({required this.item, required this.onTap, super.key});

  final AppNotificationModel item;
  final VoidCallback onTap;

  String get _content {
    final type = item.type;
    if (type == AppNotificationType.link) return item.title ?? '';
    return item.body ?? item.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final meta = NotificationTypeMeta.of(item.type);
    final content = _content.trim();
    final createdAt = item.createdAt;

    return CustomBounceable(
      onTap: onTap,
      child: Padding(
        padding:
            const PagePadding.horizontal16Symmetric() +
            const PagePadding.vertical6Symmetric(),
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

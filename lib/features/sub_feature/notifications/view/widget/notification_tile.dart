import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_type_meta.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.item, required this.onTap, super.key});

  final AppNotificationModel item;
  final VoidCallback onTap;

  String get _content => item.body ?? item.title ?? '';

  @override
  Widget build(BuildContext context) {
    final meta = NotificationTypeMeta.of(item.type, context);
    final content = _content.trim();
    final createdAt = item.createdAt;
    final isUnread = !item.read;
    final unreadColor = context.general.colorScheme.tertiary;

    return CustomBounceable(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: context.sized.dynamicHeight(.05),
        ),
        padding: const PagePadding.all(),
        margin:
            const PagePadding.horizontal16Symmetric() +
            const PagePadding.onlyBottomMedium(),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: CustomRadius.medium,
          border: Border.all(
            color: isUnread ? unreadColor : context.appColors.ink25,
            width: AppConstants.kOne.toDouble(),
          ),
        ),
        child: Row(
          spacing: AppSpacing.md,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppConstants.kForty,
              height: AppConstants.kForty,
              decoration: BoxDecoration(
                color: meta.color,
                borderRadius: CustomRadius.medium,
              ),
              child: Icon(
                meta.icon,
                size: AppIconSizes.xMedium,
                color: meta.iconColor,
              ),
            ),
            if (content.isNotEmpty)
              Expanded(
                child: Column(
                  spacing: AppSpacing.xs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralContentSubTitle(
                      value: content,
                      maxLine: AppConstants.kThree,
                      color: isUnread
                          ? context.appColors.navy800
                          : context.appColors.ink400,
                      fontWeight: isUnread ? FontWeight.w700 : FontWeight.w400,
                    ),
                    if (createdAt != null)
                      GeneralContentSmallTitle(
                        value:
                            createdAt.notificationDateBucket ==
                                NotificationDateBucket.older
                            ? createdAt.dayMonth
                            : createdAt.hm,
                        color: context.appColors.navy300,
                      ),
                  ],
                ),
              ),
            if (isUnread)
              Padding(
                padding: const PagePadding.onlyTopLow(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: unreadColor,
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox(
                    width: AppConstants.kEight,
                    height: AppConstants.kEight,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

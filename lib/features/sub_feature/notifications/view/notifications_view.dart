import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/mixin/notifications_view_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/widget/notification_tile.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/list_view/index.dart';

final class NotificationsView extends StatelessWidget
    with NotificationTypeMixin, NotificationsViewMixin {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.general.colorScheme.surface,
      appBar: PageAppBar(pageTitle: LocaleKeys.home_notifications),
      body: CustomGroupedFirestoreListView<AppNotificationModel, DateTime>(
        query: notificationsQuery,
        groupBy: notificationGroupBy,
        groupHeaderBuilder: (day) =>
            GeneralGroupSectionHeader(label: day.relativeDayLabel),
        groupCompare: notificationCompare,
        itemBuilder: (context, item) => NotificationTile(
          item: item,
          onTap: () => openNotification(context, item),
        ),
        itemTreshold: NotificationsViewMixin.notificationItemTreshold,
        separator: const Divider(
          indent: AppSpacing.xl,
          endIndent: AppSpacing.xl,
          color: AppColors.ink100,
        ),
        padding: const PagePadding.verticalVeryLowSymmetric(),
      ),
    );
  }
}

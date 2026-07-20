import 'package:easy_localization/easy_localization.dart';
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
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
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
        filter: isVisibleNotification,
        onLoading: const PlaceShimmerList(),
        onEmpty: GeneralNotFoundWidget(
          title: LocaleKeys.notFound_notification.tr(),
        ),
        itemBuilder: (context, model) => NotificationTile(
          model: model,
          onTap: () => openNotification(context, model),
        ),
        maxItem: NotificationsViewMixin.maxNotificationItems,
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

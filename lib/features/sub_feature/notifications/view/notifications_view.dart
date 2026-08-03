import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/mixin/notifications_view_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/widget/notification_tile.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/widget/notifications_empty_view.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/widget/notifications_skeleton_list.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/list_view/index.dart';

final class NotificationsView extends ConsumerWidget
    with NotificationsViewMixin {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;

    ref.watch(notificationsViewModelProvider);
    final notifier = ref.read(notificationsViewModelProvider.notifier);

    return StreamBuilder<List<AppNotificationModel>>(
      stream: notifier.unreadStream(),
      builder: (context, snapshot) {
        final unreadItems = snapshot.data ?? const [];
        final hasUnread = unreadItems.isNotEmpty;

        return Scaffold(
          backgroundColor: context.appColors.ink25,
          appBar: PageAppBar(
            pageTitle: LocaleKeys.home_notifications,
            titleTrailing: hasUnread
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary,
                      borderRadius: CustomRadius.xxLarge,
                    ),
                    child: Padding(
                      padding:
                          const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
                      child: GeneralContentSmallTitle(
                        value: '${unreadItems.length}',
                        color: colorScheme.onTertiary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : null,
            actions: [
              TextButton(
                onPressed: hasUnread
                    ? () => notifier.markAllAsRead(unreadItems)
                    : null,
                child: Text(LocaleKeys.notification_markAllRead.tr()),
              ),
            ],
          ),
          body:
              CustomGroupedFirestoreListView<
                AppNotificationModel,
                NotificationDateBucket
              >(
                query: notificationsQuery,
                groupBy: notificationGroupBy,
                groupHeaderBuilder: (bucket) =>
                    GeneralGroupSectionHeader(label: bucket.label),
                groupCompare: notificationCompare,
                itemBuilder: (context, item) => NotificationTile(
                  item: item,
                  onTap: () => notifier.openNotification(context, item),
                ),
                itemThreshold: NotificationsViewMixin.notificationItemThreshold,
                pageSize: AppConstants.kTwenty,
                onEmpty: const NotificationsEmptyView(),
                onLoading: const NotificationsSkeletonList(),
                padding: const PagePadding.verticalVeryLowSymmetric(),
              ),
        );
      },
    );
  }
}

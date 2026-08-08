import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/mixin/notifications_view_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/widget/notification_tile.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/widget/notifications_empty_view.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/widget/notifications_skeleton_list.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/list_view/index.dart';

final class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView>
    with NotificationTypeMixin, NotificationsViewMixin {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(notificationsViewModelProvider.notifier);
    final hasUnread = ref.watch(
      notificationBadgeViewModelProvider.select((state) => state.hasUnread),
    );
    final colorScheme = context.general.colorScheme;
    return Scaffold(
      backgroundColor: context.appColors.ink25,
      appBar: PageAppBar(
        pageTitle: LocaleKeys.home_notifications,
        titleTrailing: hasUnread
            ? DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.tertiary,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(
                  width: WidgetSizes.spacingXs,
                  height: WidgetSizes.spacingXs,
                ),
              )
            : null,
        actions: [
          TextButton(
            onPressed: hasUnread ? viewModel.markAllAsRead : null,
            child: Text(LocaleKeys.notification_markAllRead.tr()),
          ),
        ],
      ),
      body:
          CustomGroupedFirestoreListView<
            AppNotificationModel,
            NotificationDateBucket
          >(
            query: viewModel.notificationsQuery,
            groupBy: (item) => item.createdAt.notificationDateBucketOrNow,
            groupHeaderBuilder: (bucket) =>
                GeneralGroupSectionHeader(label: bucket.labelKey.tr()),
            groupCompare: Enum.compareByIndex,
            itemBuilder: (_, item) => NotificationTile(
              item: item,
              onTap: () => openNotification(item),
            ),
            itemThreshold: NotificationsViewModel.notificationItemThreshold,
            pageSize: AppConstants.kTwenty,
            onEmpty: const NotificationsEmptyView(),
            onLoading: const NotificationsSkeletonList(),
            padding: const PagePadding.verticalVeryLowSymmetric(),
          ),
    );
  }
}

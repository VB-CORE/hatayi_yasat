import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/notifications_view.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/sub_feature/notification_navigate/notification_navigate_parse.dart';

mixin NotificationsViewMixin
    on ConsumerState<NotificationsView>, NotificationTypeMixin {
  late final NotificationBadgeViewModel _badgeNotifier;

  @override
  void initState() {
    super.initState();
    _badgeNotifier = ref.read(notificationBadgeViewModelProvider.notifier);
  }

  @override
  void dispose() {
    unawaited(_badgeNotifier.markAllAsRead());
    super.dispose();
  }

  Future<void> openNotification(AppNotificationModel item) async {
    ref.read(notificationsViewModelProvider.notifier).markAsRead(item);
    final type = item.type;
    if (type == null || type == AppNotificationType.link) return;

    final id = item.id;
    if (id.isEmpty) return;

    await NotificationNavigateParse(context).makeWithType(
      id: id,
      type: fromAppNotifications(type),
    );
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_provider.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/notifications_view.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/sub_feature/notification_navigate/notification_navigate_parse.dart';

mixin NotificationsViewMixin
    on ConsumerState<NotificationsView>, NotificationTypeMixin {
  NotificationsViewModel? _notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notifier = ref.read(notificationsViewModelProvider.notifier);
  }

  @override
  void dispose() {
    unawaited(_notifier?.commitLastSeenTime());
    super.dispose();
  }

  Future<void> markAllAsRead() => _notifier!.markAllAsRead();

  Query<AppNotificationModel?> get notificationsQuery =>
      _notifier!.notificationsQuery;

  NotificationDateBucket notificationGroupBy(AppNotificationModel item) =>
      _notifier!.notificationGroupBy(item);

  int notificationCompare(
    NotificationDateBucket a,
    NotificationDateBucket b,
  ) => a.index.compareTo(b.index);

  bool get hasUnread => ref.read(notificationBadgeProvider.notifier).hasUnread;

  bool isUnread(AppNotificationModel item) => _notifier!.isUnread(item);

  Future<void> openNotification(
    BuildContext context,
    AppNotificationModel item,
  ) async {
    _notifier!.markAsRead(item);
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

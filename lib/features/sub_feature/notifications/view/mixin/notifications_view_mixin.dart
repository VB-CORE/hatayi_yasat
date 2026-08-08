import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/view/notifications_view.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/sub_feature/notification_navigate/notification_navigate_parse.dart';

mixin NotificationsViewMixin
    on ConsumerState<NotificationsView>, NotificationTypeMixin {
  static const notificationItemThreshold = 50;

  @override
  void initState() {
    super.initState();
    // Reaching this screen is what "seen" means; the cut-off moves here and
    // nowhere else, so the list and the badge cannot drift apart. Deferred a
    // frame because Riverpod refuses provider writes from initState.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref.read(notificationBadgeViewModelProvider.notifier).markAllSeen(),
      );
    });
  }

  Query<AppNotificationModel?> get notificationsQuery => ProjectDependencyItems
      .firestoreService
      .collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      )
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  DateTime notificationGroupBy(AppNotificationModel item) =>
      (item.createdAt ?? DateTime.now()).startOfDay;

  int notificationCompare(DateTime a, DateTime b) => b.compareTo(a);

  Future<void> openNotification(
    BuildContext context,
    AppNotificationModel item,
  ) async {
    final type = item.type;
    if (type == null) return;

    final id = type == AppNotificationType.link ? item.documentId : item.id;
    if (id.isEmpty) return;

    await NotificationNavigateParse(context).makeWithType(
      id: id,
      type: fromAppNotifications(type),
    );
  }
}

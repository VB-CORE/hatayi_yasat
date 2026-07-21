import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/sub_feature/notification_navigate/notification_navigate_parse.dart';

mixin NotificationsViewMixin on StatelessWidget, NotificationTypeMixin {
  static const maxNotificationItems = 50;

  Query<AppNotificationModel?> get notificationsQuery => ProjectDependencyItems
      .firebaseService
      .collectionReference(.notifications, AppNotificationModel())
      .orderBy(QueryOrders.createdAt.name, descending: true);

  DateTime notificationGroupBy(AppNotificationModel model) =>
      (model.createdAt ?? DateTime.now()).startOfDay;

  int notificationCompare(DateTime a, DateTime b) => b.compareTo(a);

  Future<void> openNotification(
    BuildContext context,
    AppNotificationModel model,
  ) async {
    final type = model.type;
    if (type == null) return;

    final id = type == AppNotificationType.link ? model.documentId : model.id;
    if (id.isEmpty) return;

    await NotificationNavigateParse(context).makeWithType(
      id: id,
      type: fromAppNotifications(type),
    );
  }
}

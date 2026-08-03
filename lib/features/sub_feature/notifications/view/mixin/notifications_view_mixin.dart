import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';

mixin NotificationsViewMixin on ConsumerWidget {
  static const notificationItemThreshold = 50;

  Query<AppNotificationModel?> get notificationsQuery => ProjectDependencyItems
      .firestoreService
      .collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      )
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  NotificationDateBucket notificationGroupBy(AppNotificationModel item) =>
      (item.createdAt ?? DateTime.now()).notificationDateBucket;

  int notificationCompare(
    NotificationDateBucket a,
    NotificationDateBucket b,
  ) => a.index.compareTo(b.index);
}

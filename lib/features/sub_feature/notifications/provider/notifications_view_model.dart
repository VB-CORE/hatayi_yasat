import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_type_converter.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_state.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/sub_feature/notification_navigate/notification_navigate_parse.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@riverpod
final class NotificationsViewModel extends _$NotificationsViewModel
    with ProjectDependencyMixin {
  static const notificationItemThreshold = 50;

  final SharedCache _sharedCache = SharedCache.instance;

  StreamSubscription<QuerySnapshot<AppNotificationModel?>>?
  _notificationsSubscription;

  Query<AppNotificationModel?> get _notificationsQuery =>
      firestoreService.collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      );

  Query<AppNotificationModel?> get notificationsQuery => _notificationsQuery
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  @override
  NotificationsState build() {
    _notificationsSubscription = _notificationsQuery.snapshots().listen((
      snapshot,
    ) {
      state = state.copyWith(
        notifications: snapshot.docs
            .map((document) => document.data())
            .whereType<AppNotificationModel>()
            .toList(),
      );
    });
    ref.onDispose(() => unawaited(_notificationsSubscription?.cancel()));
    return const NotificationsState();
  }

  List<AppNotificationModel> get unreadItems =>
      state.notifications.where(isUnread).toList();

  NotificationDateBucket notificationGroupBy(AppNotificationModel item) =>
      (item.createdAt ?? DateTime.now()).notificationDateBucket;

  int notificationCompare(NotificationDateBucket a, NotificationDateBucket b) =>
      a.index.compareTo(b.index);

  DateTime get _lastSeenTime =>
      _sharedCache.getLastNotificationSeenTime() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  Future<void> commitLastSeenTime() async {
    final hasNewerNotification = state.notifications.any(
      (item) =>
          item.createdAt != null && (item.createdAt!.isAfter(_lastSeenTime)),
    );
    if (!hasNewerNotification) return;
    await _sharedCache.updateNotificationLastSeenTime();
  }

  bool isUnread(AppNotificationModel item) {
    if (state.locallyReadIds.contains(item.documentId)) {
      return false;
    }

    return item.createdAt?.isAfter(_lastSeenTime) ?? false;
  }

  void markAsRead(AppNotificationModel item) {
    if (state.locallyReadIds.contains(item.documentId)) return;
    state = state.copyWith(
      locallyReadIds: {...state.locallyReadIds, item.documentId},
    );
  }

  Future<void> markAllAsRead(List<AppNotificationModel> unreadItems) async {
    if (unreadItems.isEmpty || state.isMarkingAllRead) return;
    final ids = unreadItems.map((item) => item.documentId).toSet();
    state = state.copyWith(
      locallyReadIds: {...state.locallyReadIds, ...ids},
      isMarkingAllRead: true,
    );

    await commitLastSeenTime();

    state = state.copyWith(isMarkingAllRead: false);
  }

  Future<void> openNotification(
    BuildContext context,
    AppNotificationModel item,
  ) async {
    markAsRead(item);
    final type = item.type;
    if (type == null || type == AppNotificationType.system) return;

    final id = item.id;
    if (id.isEmpty) return;

    await NotificationNavigateParse(context).makeWithType(
      id: id,
      type: fromAppNotifications(type),
    );
  }
}

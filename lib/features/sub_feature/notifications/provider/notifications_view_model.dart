import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_state.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@riverpod
final class NotificationsViewModel extends _$NotificationsViewModel
    with ProjectDependencyMixin {
  static const notificationItemThreshold = 50;

  final SharedCache _sharedCache = SharedCache.instance;

  StreamSubscription<QuerySnapshot<AppNotificationModel?>>? _unreadSubscription;

  late final Query<AppNotificationModel?> notificationsQuery = firestoreService
      .collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      )
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  @override
  NotificationsState build() {
    _listenForUnread();
    ref.onDispose(() => unawaited(_unreadSubscription?.cancel()));
    return const NotificationsState();
  }

  // main app bar kısmında bildirim ikonuna bildirim olup olmadığını göstermek için kullanılıyor. Bu yüzden burada unread notificationları dinliyoruz.
  void _listenForUnread() {
    unawaited(_unreadSubscription?.cancel());
    _unreadSubscription = notificationsQuery
        .where(FirestoreFields.createdAt.name, isGreaterThan: _lastSeenTime)
        .snapshots()
        .listen((snapshot) {
          state = state.copyWith(
            unreadIds: snapshot.docs.map((document) => document.id).toSet(),
          );
        });
  }

  DateTime get _lastSeenTime =>
      _sharedCache.getLastNotificationSeenTime() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  bool get hasUnread => state.unreadIds.isNotEmpty;

  int get unreadCount => state.unreadIds.length;

  NotificationDateBucket notificationGroupBy(AppNotificationModel item) =>
      (item.createdAt ?? DateTime.now()).notificationDateBucket;

  bool isUnread(AppNotificationModel item) =>
      state.unreadIds.contains(item.documentId);

  void markAsRead(AppNotificationModel item) {
    if (!isUnread(item)) return;
    state = state.copyWith(
      unreadIds: {...state.unreadIds}..remove(item.documentId),
    );
  }

  Future<void> commitLastSeenTime() async {
    if (state.unreadIds.isEmpty) return;
    await _sharedCache.updateNotificationLastSeenTime();
    _listenForUnread();
  }

  Future<void> markAllAsRead() async {
    if (state.unreadIds.isEmpty || state.isMarkingAllRead) return;
    state = state.copyWith(isMarkingAllRead: true);

    await commitLastSeenTime();

    state = state.copyWith(isMarkingAllRead: false);
  }
}

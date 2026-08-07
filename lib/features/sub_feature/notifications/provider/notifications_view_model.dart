import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_provider.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_state.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@riverpod
final class NotificationsViewModel extends _$NotificationsViewModel
    with ProjectDependencyMixin {
  static const notificationItemThreshold = 50;

  final SharedCache _sharedCache = SharedCache.instance;

  late final Query<AppNotificationModel?> notificationsQuery = firestoreService
      .collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      )
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  @override
  NotificationsState build() => const NotificationsState();

  DateTime get _lastSeenTime =>
      _sharedCache.getLastNotificationSeenTime() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  NotificationDateBucket notificationGroupBy(AppNotificationModel item) =>
      (item.createdAt ?? DateTime.now()).notificationDateBucket;

  bool isUnread(AppNotificationModel item) {
    if (state.locallyReadIds.contains(item.documentId)) return false;
    return item.createdAt?.isAfter(_lastSeenTime) ?? false;
  }

  void markAsRead(AppNotificationModel item) {
    if (!isUnread(item)) return;
    state = state.copyWith(
      locallyReadIds: {...state.locallyReadIds, item.documentId},
    );
  }

  Future<void> commitLastSeenTime() =>
      ref.read(notificationBadgeProvider.notifier).markAllAsRead();

  Future<void> markAllAsRead() async {
    if (state.isMarkingAllRead) return;
    state = state.copyWith(isMarkingAllRead: true);
    await commitLastSeenTime();
    state = state.copyWith(isMarkingAllRead: false, locallyReadIds: const {});
  }
}

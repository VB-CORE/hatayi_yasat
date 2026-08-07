import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/model/notification_date_bucket.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_provider.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@Riverpod(keepAlive: true)
final class NotificationsViewModel extends _$NotificationsViewModel
    with ProjectDependencyMixin {
  static const notificationItemThreshold = 50;

  late final Query<AppNotificationModel?> notificationsQuery = firestoreService
      .collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      )
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  @override
  NotificationsState build() => const NotificationsState();

  NotificationDateBucket notificationGroupBy(AppNotificationModel item) =>
      (item.createdAt ?? DateTime.now()).notificationDateBucket;

  void markAsRead(AppNotificationModel item) {
    if (!state.isUnread(item)) return;
    state = state.copyWith(
      locallyReadIds: {...state.locallyReadIds, item.documentId},
    );
  }

  Future<void> markAllAsRead() async {
    if (state.isMarkingAllRead) return;
    state = state.copyWith(isMarkingAllRead: true);
    await ref.read(notificationBadgeProvider.notifier).markAllAsRead();
    state = state.copyWith(isMarkingAllRead: false, locallyReadIds: const {});
  }

  Future<void> commitLastSeenTime() async {
    await ref.read(notificationBadgeProvider.notifier).markAllAsRead();
    state = state.copyWith(locallyReadIds: const {});
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@riverpod
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
  NotificationsState build() => NotificationsState(
    seenBaseline: ref.read(notificationBadgeViewModelProvider).lastSeenTime,
  );

  void markAsRead(AppNotificationModel item) {
    if (!state.isUnread(item)) return;
    state = state.copyWith(
      locallyReadIds: {...state.locallyReadIds, item.documentId},
    );
  }

  Future<void> markAllAsRead() async {
    await ref.read(notificationBadgeViewModelProvider.notifier).markAllAsRead();
    if (!ref.mounted) return;
    state = state.copyWith(
      seenBaseline: ref.read(notificationBadgeViewModelProvider).lastSeenTime,
      locallyReadIds: const {},
    );
  }
}

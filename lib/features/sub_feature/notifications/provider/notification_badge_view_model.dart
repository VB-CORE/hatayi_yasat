import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_state.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_badge_view_model.g.dart';

@riverpod
final class NotificationBadgeViewModel extends _$NotificationBadgeViewModel
    with ProjectDependencyMixin {
  final SharedCache _sharedCache = SharedCache.instance;

  StreamSubscription<QuerySnapshot<AppNotificationModel?>>? _latestSubscription;

  @override
  NotificationBadgeState build() {
    _latestSubscription = firestoreService
        .collectionReference(
          CollectionPaths.notifications,
          AppNotificationModel(),
        )
        .orderBy(FirestoreFields.createdAt.name, descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
          state = state.copyWith(
            lastSeenTime: _lastSeenTime,
            latestCreatedAt: snapshot.docs.firstOrNull?.data()?.createdAt,
          );
          unawaited(_syncBadge());
        });
    ref.onDispose(() => unawaited(_latestSubscription?.cancel()));
    return NotificationBadgeState(lastSeenTime: _lastSeenTime);
  }

  DateTime get _lastSeenTime =>
      _sharedCache.getLastNotificationSeenTime() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  /// Re-reads the count from scratch. The stream only fires when the feed
  /// itself changes, but the OS badge is also written by APNs while the app is
  /// asleep — coming back to the foreground has to correct that number.
  Future<void> refresh() => _syncBadge();

  Future<void> markAllAsRead() async {
    if (!ref.mounted || !state.hasUnread) return;
    await _sharedCache.updateNotificationLastSeenTime();
    if (!ref.mounted) return;
    state = state.copyWith(lastSeenTime: _lastSeenTime, unreadCount: 0);
    await notificationBadgeService.setBadge(0);
  }

  Future<void> _syncBadge() async {
    final count = await notificationBadgeService.unreadCountSince(
      state.lastSeenTime,
    );
    if (!ref.mounted) return;
    state = state.copyWith(unreadCount: count);
    await notificationBadgeService.setBadge(count);
  }
}

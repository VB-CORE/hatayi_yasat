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
          state = NotificationBadgeState(
            lastSeenTime: _lastSeenTime,
            latestCreatedAt: snapshot.docs.firstOrNull?.data()?.createdAt,
          );
        });
    ref.onDispose(() => unawaited(_latestSubscription?.cancel()));
    return NotificationBadgeState(lastSeenTime: _lastSeenTime);
  }

  DateTime get _lastSeenTime =>
      _sharedCache.getLastNotificationSeenTime() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  Future<void> markAllAsRead() async {
    if (!ref.mounted || !state.hasUnread) return;
    await _sharedCache.updateNotificationLastSeenTime();
    if (!ref.mounted) return;
    state = state.copyWith(lastSeenTime: _lastSeenTime);
  }
}

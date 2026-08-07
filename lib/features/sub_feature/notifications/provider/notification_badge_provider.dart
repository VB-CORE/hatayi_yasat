import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_badge_provider.g.dart';

@riverpod
final class NotificationBadge extends _$NotificationBadge
    with ProjectDependencyMixin {
  final SharedCache _sharedCache = SharedCache.instance;

  StreamSubscription<QuerySnapshot<AppNotificationModel?>>? _latestSubscription;

  @override
  bool build() {
    _latestSubscription = firestoreService
        .collectionReference(
          CollectionPaths.notifications,
          AppNotificationModel(),
        )
        .orderBy(FirestoreFields.createdAt.name, descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
          final latest = snapshot.docs.firstOrNull?.data()?.createdAt;
          state = latest?.isAfter(_lastSeenTime) ?? false;
        });
    ref.onDispose(() => unawaited(_latestSubscription?.cancel()));
    return false;
  }

  DateTime get _lastSeenTime =>
      _sharedCache.getLastNotificationSeenTime() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  Future<void> markAllAsRead() async {
    if (!state) return;
    await _sharedCache.updateNotificationLastSeenTime();
    state = false;
  }
}

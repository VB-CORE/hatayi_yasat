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

  StreamSubscription<QuerySnapshot<AppNotificationModel?>>? _latestSubscription;

  late final Query<AppNotificationModel?> notificationsQuery = firestoreService
      .collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      )
      .orderBy(FirestoreFields.createdAt.name, descending: true);

  @override
  NotificationsState build() {
    // main app bar'daki bildirim ikonuna rozet koymak için sadece en yeni
    // bildirimin tarihine bakıyoruz — tüm okunmamışları çekmeye gerek yok.
    _latestSubscription = notificationsQuery.limit(1).snapshots().listen((
      snapshot,
    ) {
      state = state.copyWith(
        latestNotificationTime: snapshot.docs.firstOrNull?.data()?.createdAt,
      );
    });
    ref.onDispose(() => unawaited(_latestSubscription?.cancel()));
    return NotificationsState(lastSeenTime: _lastSeenTime);
  }

  DateTime get _lastSeenTime =>
      _sharedCache.getLastNotificationSeenTime() ??
      DateTime.fromMillisecondsSinceEpoch(0);

  bool get hasUnread => state.hasUnread;

  NotificationDateBucket notificationGroupBy(AppNotificationModel item) =>
      (item.createdAt ?? DateTime.now()).notificationDateBucket;

  bool isUnread(AppNotificationModel item) =>
      item.createdAt?.isAfter(state.lastSeenTime) ?? false;

  Future<void> markAsRead(AppNotificationModel item) async {
    final createdAt = item.createdAt;
    if (createdAt == null || !isUnread(item)) return;
    await _updateLastSeenTime(createdAt);
  }

  Future<void> commitLastSeenTime() async {
    if (!state.hasUnread) return;
    await _updateLastSeenTime(DateTime.now());
  }

  Future<void> markAllAsRead() async {
    if (!state.hasUnread || state.isMarkingAllRead) return;
    state = state.copyWith(isMarkingAllRead: true);

    await _updateLastSeenTime(DateTime.now());

    state = state.copyWith(isMarkingAllRead: false);
  }

  Future<void> _updateLastSeenTime(DateTime at) async {
    await _sharedCache.updateNotificationLastSeenTime(at: at);
    state = state.copyWith(lastSeenTime: at);
  }
}

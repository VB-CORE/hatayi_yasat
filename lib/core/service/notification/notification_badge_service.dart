import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';

/// Keeps the app icon badge and the in-app bell honest about how many
/// notifications arrived since the person last looked.
///
/// `CollectionPaths.notifications` is a single global feed with no per-user
/// read state, so "unread" can only mean *published after the last visit*.
/// That cut-off lives on the device in [SharedCache.getLastNotificationSeenTime].
///
/// This only governs the badge while the app is running or resuming. When the
/// app is terminated iOS takes the badge straight from the APNs payload, so a
/// wrong number pushed by the backend stands until the app is next opened.
abstract interface class NotificationBadgeService {
  /// Recomputes the unread count and pushes it to the OS badge.
  Future<int> refresh();

  /// Marks everything published so far as seen and clears the badge.
  Future<void> markAllSeen();
}

final class FirestoreNotificationBadgeService
    implements NotificationBadgeService {
  FirestoreNotificationBadgeService({
    required CustomFirestoreService firestoreService,
    SharedCache? sharedCache,
  }) : _firestoreService = firestoreService,
       _sharedCache = sharedCache ?? SharedCache.instance;

  final CustomFirestoreService _firestoreService;
  final SharedCache _sharedCache;

  /// Past this point the exact number stops carrying information and the
  /// aggregation is needlessly wide.
  static const _maxBadgeCount = 99;

  @override
  Future<int> refresh() async {
    final count = await _unreadCount();
    await _applyBadge(count);
    return count;
  }

  @override
  Future<void> markAllSeen() async {
    await _sharedCache.updateNotificationLastSeenTime();
    await _applyBadge(0);
  }

  Future<int> _unreadCount() async {
    final lastSeen = _sharedCache.getLastNotificationSeenTime();
    // A device that has never opened the list has no cut-off to compare
    // against; treating the whole archive as unread would show a wild number,
    // so it starts clean instead.
    if (lastSeen == null) {
      await _sharedCache.updateNotificationLastSeenTime();
      return 0;
    }

    try {
      final snapshot = await _firestoreService
          .collectionReference(CollectionPaths.notifications, AppNotificationModel())
          .where(
            FirestoreFields.createdAt.name,
            isGreaterThan: Timestamp.fromDate(lastSeen),
          )
          .count()
          .get()
          .timeout(_firestoreService.timeoutDuration);
      final count = snapshot.count ?? 0;
      return count > _maxBadgeCount ? _maxBadgeCount : count;
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return 0;
    }
  }

  Future<void> _applyBadge(int count) async {
    try {
      if (!await AppBadgePlus.isSupported()) return;
      await AppBadgePlus.updateBadge(count);
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
    }
  }
}

import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

/// Owns the number on the app icon.
///
/// `CollectionPaths.notifications` is a single global feed with no per-user
/// read state, so "unread" can only mean *published after the cut-off*. The
/// cut-off itself belongs to `NotificationBadgeViewModel`; this service is only
/// asked how many came after it and told what to show.
///
/// It governs the badge only while the app is running or resuming. Once the app
/// is terminated iOS takes the badge straight from the APNs payload, so a wrong
/// number pushed by the backend stands until the app is next opened.
abstract interface class NotificationBadgeService {
  /// How many notifications were published after [lastSeen].
  Future<int> unreadCountSince(DateTime lastSeen);

  /// Writes [count] to the OS app icon badge. Zero clears it.
  Future<void> setBadge(int count);
}

final class FirestoreNotificationBadgeService
    implements NotificationBadgeService {
  FirestoreNotificationBadgeService({
    required CustomFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  final CustomFirestoreService _firestoreService;

  /// Past this point the exact number stops carrying information and the
  /// aggregation is needlessly wide.
  static const _maxBadgeCount = 99;

  @override
  Future<int> unreadCountSince(DateTime lastSeen) async {
    try {
      final snapshot = await _firestoreService
          .collectionReference(
            CollectionPaths.notifications,
            AppNotificationModel(),
          )
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

  @override
  Future<void> setBadge(int count) async {
    try {
      if (!await AppBadgePlus.isSupported()) return;
      await AppBadgePlus.updateBadge(count);
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
    }
  }
}

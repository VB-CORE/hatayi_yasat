import 'package:equatable/equatable.dart';

final class NotificationBadgeState extends Equatable {
  const NotificationBadgeState({
    required this.lastSeenTime,
    this.latestCreatedAt,
    this.unreadCount = 0,
  });

  final DateTime lastSeenTime;
  final DateTime? latestCreatedAt;

  /// Drives the OS app icon badge, which needs a number rather than the
  /// boolean the in-app dot is happy with.
  final int unreadCount;

  bool get hasUnread => latestCreatedAt?.isAfter(lastSeenTime) ?? false;

  @override
  List<Object?> get props => [lastSeenTime, latestCreatedAt, unreadCount];

  NotificationBadgeState copyWith({
    DateTime? lastSeenTime,
    DateTime? latestCreatedAt,
    int? unreadCount,
  }) {
    return NotificationBadgeState(
      lastSeenTime: lastSeenTime ?? this.lastSeenTime,
      latestCreatedAt: latestCreatedAt ?? this.latestCreatedAt,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

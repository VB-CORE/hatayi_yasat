import 'package:equatable/equatable.dart';

final class NotificationBadgeState extends Equatable {
  const NotificationBadgeState({
    required this.lastSeenTime,
    this.latestCreatedAt,
  });

  final DateTime lastSeenTime;
  final DateTime? latestCreatedAt;

  bool get hasUnread => latestCreatedAt?.isAfter(lastSeenTime) ?? false;

  @override
  List<Object?> get props => [lastSeenTime, latestCreatedAt];

  NotificationBadgeState copyWith({
    DateTime? lastSeenTime,
    DateTime? latestCreatedAt,
  }) {
    return NotificationBadgeState(
      lastSeenTime: lastSeenTime ?? this.lastSeenTime,
      latestCreatedAt: latestCreatedAt ?? this.latestCreatedAt,
    );
  }
}

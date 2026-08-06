import 'package:equatable/equatable.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    required this.lastSeenTime,
    this.isMarkingAllRead = false,
    this.latestNotificationTime,
  });

  final DateTime lastSeenTime;
  final bool isMarkingAllRead;
  final DateTime? latestNotificationTime;

  bool get hasUnread => latestNotificationTime?.isAfter(lastSeenTime) ?? false;

  @override
  List<Object?> get props => [
    lastSeenTime,
    isMarkingAllRead,
    latestNotificationTime,
  ];

  NotificationsState copyWith({
    DateTime? lastSeenTime,
    bool? isMarkingAllRead,
    DateTime? latestNotificationTime,
  }) {
    return NotificationsState(
      lastSeenTime: lastSeenTime ?? this.lastSeenTime,
      isMarkingAllRead: isMarkingAllRead ?? this.isMarkingAllRead,
      latestNotificationTime:
          latestNotificationTime ?? this.latestNotificationTime,
    );
  }
}

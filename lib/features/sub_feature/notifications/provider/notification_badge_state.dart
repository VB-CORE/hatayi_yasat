import 'package:equatable/equatable.dart';

final class NotificationBadgeState extends Equatable {
  const NotificationBadgeState({this.unreadCount = 0, this.isFetching = false});

  final int unreadCount;
  final bool isFetching;

  bool get hasUnread => unreadCount > 0;

  @override
  List<Object> get props => [unreadCount, isFetching];

  NotificationBadgeState copyWith({int? unreadCount, bool? isFetching}) {
    return NotificationBadgeState(
      unreadCount: unreadCount ?? this.unreadCount,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}

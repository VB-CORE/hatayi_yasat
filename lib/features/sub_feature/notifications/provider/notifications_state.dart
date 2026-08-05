import 'package:equatable/equatable.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.isMarkingAllRead = false,
    this.unreadIds = const {},
  });

  final bool isMarkingAllRead;
  final Set<String> unreadIds;

  @override
  List<Object> get props => [isMarkingAllRead, unreadIds];

  NotificationsState copyWith({
    bool? isMarkingAllRead,
    Set<String>? unreadIds,
  }) {
    return NotificationsState(
      isMarkingAllRead: isMarkingAllRead ?? this.isMarkingAllRead,
      unreadIds: unreadIds ?? this.unreadIds,
    );
  }
}

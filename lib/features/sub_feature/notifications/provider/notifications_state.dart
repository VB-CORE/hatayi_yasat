import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.locallyReadIds = const {},
    this.isMarkingAllRead = false,
    this.notifications = const [],
  });

  final Set<String> locallyReadIds;
  final bool isMarkingAllRead;
  final List<AppNotificationModel> notifications;

  @override
  List<Object> get props => [locallyReadIds, isMarkingAllRead, notifications];

  NotificationsState copyWith({
    Set<String>? locallyReadIds,
    bool? isMarkingAllRead,
    List<AppNotificationModel>? notifications,
  }) {
    return NotificationsState(
      locallyReadIds: locallyReadIds ?? this.locallyReadIds,
      isMarkingAllRead: isMarkingAllRead ?? this.isMarkingAllRead,
      notifications: notifications ?? this.notifications,
    );
  }
}

import 'package:equatable/equatable.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.locallyReadIds = const {},
    this.isMarkingAllRead = false,
  });

  final Set<String> locallyReadIds;
  final bool isMarkingAllRead;

  @override
  List<Object> get props => [locallyReadIds, isMarkingAllRead];

  NotificationsState copyWith({
    Set<String>? locallyReadIds,
    bool? isMarkingAllRead,
  }) {
    return NotificationsState(
      locallyReadIds: locallyReadIds ?? this.locallyReadIds,
      isMarkingAllRead: isMarkingAllRead ?? this.isMarkingAllRead,
    );
  }
}

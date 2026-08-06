import 'package:equatable/equatable.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.isMarkingAllRead = false,
    this.locallyReadIds = const {},
  });

  final bool isMarkingAllRead;
  final Set<String> locallyReadIds;

  @override
  List<Object> get props => [isMarkingAllRead, locallyReadIds];

  NotificationsState copyWith({
    bool? isMarkingAllRead,
    Set<String>? locallyReadIds,
  }) {
    return NotificationsState(
      isMarkingAllRead: isMarkingAllRead ?? this.isMarkingAllRead,
      locallyReadIds: locallyReadIds ?? this.locallyReadIds,
    );
  }
}

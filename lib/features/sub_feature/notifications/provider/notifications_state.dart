import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    required this.seenBaseline,
    this.locallyReadIds = const {},
  });

  final DateTime seenBaseline;
  final Set<String> locallyReadIds;

  bool isUnread(AppNotificationModel item) {
    if (locallyReadIds.contains(item.documentId)) return false;
    return item.createdAt?.isAfter(seenBaseline) ?? false;
  }

  @override
  List<Object> get props => [seenBaseline, locallyReadIds];

  NotificationsState copyWith({
    DateTime? seenBaseline,
    Set<String>? locallyReadIds,
  }) {
    return NotificationsState(
      seenBaseline: seenBaseline ?? this.seenBaseline,
      locallyReadIds: locallyReadIds ?? this.locallyReadIds,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.isMarkingAllRead = false,
    this.locallyReadIds = const {},
  });

  final bool isMarkingAllRead;
  final Set<String> locallyReadIds;

  bool isUnread(AppNotificationModel item) {
    if (locallyReadIds.contains(item.documentId)) return false;
    final lastSeenTime =
        SharedCache.instance.getLastNotificationSeenTime() ??
        DateTime.fromMillisecondsSinceEpoch(0);
    return item.createdAt?.isAfter(lastSeenTime) ?? false;
  }

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

import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_badge_view_model.g.dart';

/// Kept alive so the app bar bell and the OS badge never disagree: the count is
/// refreshed from lifecycle and push events that outlive any single screen.
@Riverpod(keepAlive: true)
final class NotificationBadgeViewModel extends _$NotificationBadgeViewModel
    with ProjectDependencyMixin {
  @override
  NotificationBadgeState build() => const NotificationBadgeState();

  Future<void> refresh() async {
    if (state.isFetching) return;
    state = state.copyWith(isFetching: true);
    final count = await notificationBadgeService.refresh();
    state = state.copyWith(unreadCount: count, isFetching: false);
  }

  Future<void> markAllSeen() async {
    await notificationBadgeService.markAllSeen();
    state = state.copyWith(unreadCount: 0, isFetching: false);
  }
}

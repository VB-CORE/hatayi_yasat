import 'dart:async';
import 'package:collection/collection.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/admin_panel/model/admin_permission.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_panel_service_provider.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_users_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_users_view_model.g.dart';

@riverpod
final class AdminUsersViewModel extends _$AdminUsersViewModel
    with ProjectDependencyMixin {
  static const int _pageSize = 20;

  @override
  AdminUsersState build() {
    unawaited(_loadFirstPage());
    return const AdminUsersState(isFetching: true);
  }

  Future<void> _loadFirstPage() async {
    final List<AppUser> users;
    try {
      users = await ref
          .read(adminPanelServiceProvider)
          .fetchUsers(limit: _pageSize);
    } on Exception {
      if (!ref.mounted) return;
      state = state.copyWith(isFetching: false, isError: true);
      return;
    }
    if (!ref.mounted) return;
    state = state.copyWith(
      users: users,
      isFetching: false,
      hasMore: users.length == _pageSize,
    );
  }

  Future<void> fetchNextPage() async {
    if (state.isFetching || state.isFetchingMore || !state.hasMore) return;
    final lastUser = state.users.lastOrNull;
    if (lastUser == null) return;
    state = state.copyWith(isFetchingMore: true);
    final List<AppUser> users;
    try {
      users = await ref
          .read(adminPanelServiceProvider)
          .fetchUsers(limit: _pageSize, startAfterUid: lastUser.uid);
    } on Exception {
      if (!ref.mounted) return;
      state = state.copyWith(
        isFetchingMore: false,
        actionMessageKey: LocaleKeys.admin_usersLoadFailed,
      );
      return;
    }
    if (!ref.mounted) return;
    state = state.copyWith(
      users: [...state.users, ...users],
      isFetchingMore: false,
      hasMore: users.length == _pageSize,
    );
  }

  Future<void> retry() async {
    state = state.copyWith(isFetching: true, isError: false);
    await _loadFirstPage();
  }

  Future<void> togglePermission({
    required String uid,
    required AdminPermission permission,
  }) async {
    if (state.processingUids.contains(uid)) return;
    final current = state.users.firstWhereOrNull((user) => user.uid == uid);
    if (current == null) return;
    final updated = permission.toggle(current);
    state = state.copyWith(
      users: state.users
          .map((user) => user.uid == uid ? updated : user)
          .toList(),
      processingUids: {...state.processingUids, uid},
    );
    final success = await ref
        .read(adminPanelServiceProvider)
        .updateUserPermissions(updated);
    if (!ref.mounted) return;
    final remaining = {...state.processingUids}..remove(uid);
    if (success) {
      state = state.copyWith(processingUids: remaining);
      return;
    }
    final failed = state.users.firstWhereOrNull((user) => user.uid == uid);
    if (failed == null) {
      state = state.copyWith(processingUids: remaining);
      return;
    }
    final reverted = permission.toggle(failed);
    state = state.copyWith(
      users: state.users
          .map((user) => user.uid == uid ? reverted : user)
          .toList(),
      processingUids: remaining,
      actionMessageKey: LocaleKeys.admin_permissionUpdateFailed,
    );
  }

  void consumeActionMessage() =>
      state = state.copyWith(clearActionMessage: true);
}

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_users_state.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_users_view_model.dart';
import 'package:lifeclient/features/admin_panel/view/admin_users_tab.dart';
import 'package:lifeclient/features/admin_panel/view/widget/admin_user_detail_sheet.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin AdminUsersViewMixin
    on ConsumerState<AdminUsersTab>, AppProviderMixin<AdminUsersTab> {
  static const double _nextPageTriggerOffset = 320;

  @override
  void initState() {
    super.initState();
    ref.listenManual(adminUsersViewModelProvider, onActionMessage);
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0) return false;
    if (notification.metrics.extentAfter >= _nextPageTriggerOffset) {
      return false;
    }
    unawaited(ref.read(adminUsersViewModelProvider.notifier).fetchNextPage());
    return false;
  }

  void onActionMessage(AdminUsersState? previous, AdminUsersState next) {
    final messageKey = next.actionMessageKey;
    if (messageKey == null) return;
    appProvider.showSnackbarMessage(messageKey.tr());
    ref.read(adminUsersViewModelProvider.notifier).consumeActionMessage();
  }

  Future<void> onUserTap(String uid) =>
      AdminUserDetailSheet.show(context, uid: uid);

  Future<void> onRetry() =>
      ref.read(adminUsersViewModelProvider.notifier).retry();
}

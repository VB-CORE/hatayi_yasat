import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_applications_state.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_applications_view_model.dart';
import 'package:lifeclient/features/admin_panel/view/admin_applications_tab.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin AdminApplicationsViewMixin
    on
        ConsumerState<AdminApplicationsTab>,
        AppProviderMixin<AdminApplicationsTab> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(adminApplicationsViewModelProvider, onActionMessage);
  }

  void onActionMessage(
    AdminApplicationsState? previous,
    AdminApplicationsState next,
  ) {
    final messageKey = next.actionMessageKey;
    if (messageKey == null) return;
    appProvider.showSnackbarMessage(messageKey.tr());
    ref
        .read(adminApplicationsViewModelProvider.notifier)
        .consumeActionMessage();
  }

  Future<void> onApprove(String uid) =>
      ref.read(adminApplicationsViewModelProvider.notifier).approve(uid);

  Future<void> onReject(String uid) =>
      ref.read(adminApplicationsViewModelProvider.notifier).reject(uid);

  Future<void> onRetry() =>
      ref.read(adminApplicationsViewModelProvider.notifier).retry();
}

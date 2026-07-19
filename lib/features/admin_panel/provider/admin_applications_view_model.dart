import 'dart:async';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/admin_panel/model/merchant_application_model.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_applications_state.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_panel_service_provider.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_applications_view_model.g.dart';

@riverpod
final class AdminApplicationsViewModel extends _$AdminApplicationsViewModel
    with ProjectDependencyMixin {
  @override
  AdminApplicationsState build() {
    unawaited(_loadApplications());
    return const AdminApplicationsState(isFetching: true);
  }

  Future<void> _loadApplications() async {
    final List<MerchantApplicationModel> applications;
    try {
      applications = await ref
          .read(adminPanelServiceProvider)
          .fetchPendingApplications();
    } on Exception {
      if (!ref.mounted) return;
      state = state.copyWith(isFetching: false, isError: true);
      return;
    }
    if (!ref.mounted) return;
    state = state.copyWith(applications: applications, isFetching: false);
  }

  Future<void> retry() async {
    state = state.copyWith(isFetching: true, isError: false);
    await _loadApplications();
  }

  Future<void> approve(String uid) async {
    if (state.isBusy) return;
    state = state.copyWith(processingUid: uid);
    final success = await ref
        .read(adminPanelServiceProvider)
        .approveApplication(uid);
    if (!ref.mounted) return;
    if (success) {
      state = state.copyWith(
        applications: state.applications
            .map(
              (application) => application.uid == uid
                  ? application.copyWith(
                      status: MerchantApplicationStatus.approved,
                    )
                  : application,
            )
            .toList(),
        clearProcessingUid: true,
        actionMessageKey: LocaleKeys.admin_approveSuccess,
      );
    } else {
      state = state.copyWith(
        clearProcessingUid: true,
        actionMessageKey: LocaleKeys.admin_approveFailed,
      );
    }
  }

  Future<void> reject(String uid) async {
    if (state.isBusy) return;
    state = state.copyWith(processingUid: uid);
    final success = await ref
        .read(adminPanelServiceProvider)
        .rejectApplication(uid);
    if (!ref.mounted) return;
    if (success) {
      state = state.copyWith(
        applications: state.applications
            .map(
              (application) => application.uid == uid
                  ? application.copyWith(
                      status: MerchantApplicationStatus.rejected,
                    )
                  : application,
            )
            .toList(),
        clearProcessingUid: true,
        actionMessageKey: LocaleKeys.admin_rejectSuccess,
      );
    } else {
      state = state.copyWith(
        clearProcessingUid: true,
        actionMessageKey: LocaleKeys.admin_rejectFailed,
      );
    }
  }

  void consumeActionMessage() =>
      state = state.copyWith(clearActionMessage: true);
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/admin_panel/model/merchant_application_model.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_applications_view_model.dart';
import 'package:lifeclient/features/admin_panel/view/mixin/admin_applications_view_mixin.dart';
import 'package:lifeclient/features/admin_panel/view/widget/admin_list_shimmer.dart';
import 'package:lifeclient/features/admin_panel/view/widget/admin_verified_badge.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';

part 'widget/admin_application_card.dart';

final class AdminApplicationsTab extends ConsumerStatefulWidget {
  const AdminApplicationsTab({super.key});

  @override
  ConsumerState<AdminApplicationsTab> createState() =>
      _AdminApplicationsTabState();
}

final class _AdminApplicationsTabState
    extends ConsumerState<AdminApplicationsTab>
    with AppProviderMixin<AdminApplicationsTab>, AdminApplicationsViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminApplicationsViewModelProvider);
    if (state.isError) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.admin_applicationsLoadFailed.tr(),
        onRefresh: onRetry,
      );
    }
    if (state.isFetching) return const AdminListShimmer();
    if (state.applications.isEmpty) {
      return Center(
        child: GeneralContentSubTitle(
          value: LocaleKeys.admin_noPendingApplications.tr(),
        ),
      );
    }
    return GeneralSemantic(
      semanticKey: GeneralSemanticKeys.adminApplicationsTab,
      child: ListView.separated(
        padding: const PagePadding.generalAllLow(),
        itemCount: state.applications.length,
        separatorBuilder: (context, index) => const EmptyBox.smallHeight(),
        itemBuilder: (context, index) {
          final application = state.applications[index];
          return _AdminApplicationCard(
            key: ValueKey(application.uid),
            application: application,
            isProcessing: state.processingUid == application.uid,
            isBusy: state.isBusy,
            onApprove: () => onApprove(application.uid),
            onReject: () => onReject(application.uid),
          );
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/community/group_detail/details/view/group_details_view.dart';
import 'package:lifeclient/features/community/group_detail/details/view/widget/close_group_confirm_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupDetailsViewMixin
    on ConsumerState<GroupDetailsView>, AppProviderMixin<GroupDetailsView> {
  void leaveGroup() {
    appProvider.showSnackbarMessage(
      LocaleKeys.community_groupDetail_details_leaveSuccess.tr(),
    );
    context.pop();
  }

  Future<void> closeGroup() async {
    final isApproved = await CloseGroupConfirmSheet.show(context);
    if (isApproved == null || !mounted) return;
    appProvider.showSnackbarMessage(
      LocaleKeys.community_groupDetail_details_closeGroupSuccess.tr(),
    );
    context.pop();
  }
}

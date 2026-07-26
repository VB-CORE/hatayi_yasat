import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/community/group_detail/details/view/group_details_view.dart';
import 'package:lifeclient/features/community/group_detail/details/view/widget/delete_group_confirm_sheet.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/features/community/groups/provider/groups_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupDetailsViewMixin
    on ConsumerState<GroupDetailsView>, AppProviderMixin<GroupDetailsView> {
  Future<void> leaveGroup() async {
    final hasLeft = await ref
        .read(groupMembersViewModelProvider(widget.model.id).notifier)
        .leave();
    if (!mounted) return;

    if (!hasLeft) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    appProvider.showSnackbarMessage(
      LocaleKeys.community_groupDetail_details_leaveSuccess.tr(),
    );
    context.pop();
  }

  Future<void> deleteGroup() async {
    final isConfirmed = await DeleteGroupConfirmSheet.show(context);
    if (isConfirmed != true || !mounted) return;

    final isDeleted = await ref
        .read(groupsViewModelProvider.notifier)
        .deleteGroup(widget.model.id);
    if (!mounted) return;

    if (!isDeleted) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    appProvider.showSnackbarMessage(
      LocaleKeys.community_groupDetail_details_deleteGroupSuccess.tr(),
    );
    context.pop();
  }
}

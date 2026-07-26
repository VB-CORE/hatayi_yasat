import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/groups/provider/groups_view_model.dart';
import 'package:lifeclient/features/community/groups/view/groups_view.dart';
import 'package:lifeclient/features/community/groups/view/widget/join_group_confirm_sheet.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/login_required_dialog.dart';

mixin GroupsViewMixin
    on ConsumerState<GroupsView>, AppProviderMixin<GroupsView> {
  Future<void> onGroupTap(GroupModel model) async {
    if (!ref.read(authViewModelProvider).isAuthenticated) {
      return LoginRequiredDialog.show(context);
    }

    final groups = ref.read(groupsViewModelProvider.notifier);
    final isMember = await groups.isMemberOf(model.id);
    if (!mounted) return;

    if (isMember) return _openGroup(model);

    final isConfirmed = await JoinGroupConfirmSheet.show(context);
    if (isConfirmed != true || !mounted) return;

    final hasJoined = await groups.joinGroup(model.id);
    if (!mounted) return;

    if (!hasJoined) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    await _openGroup(model);
  }

  Future<void> _openGroup(GroupModel model) =>
      GroupDetailRoute($extra: model).push<void>(context);
}

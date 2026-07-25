import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/groups/provider/groups_view_model.dart';
import 'package:lifeclient/features/community/groups/view/groups_view.dart';
import 'package:lifeclient/features/community/groups/view/widget/join_group_confirm_sheet.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupsViewMixin
    on ConsumerState<GroupsView>, AppProviderMixin<GroupsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(groupsViewModelProvider.notifier).fetchGroups();
    });
  }

  bool get canCreateGroup {
    return ref.read(authViewModelProvider).user?.canCreateGroup ?? false;
  }

  Future<void> onGroupTap(GroupModel model) async {
    final authState = ref.read(authViewModelProvider);
    final uid = authState is Authenticated ? authState.user.uid : null;

    final isCreator = uid != null && model.creatorUid == uid;
    final isMember =
        isCreator ||
        await ref.read(groupsViewModelProvider.notifier).isMemberOf(model.id);
    if (!mounted) return;

    if (isMember) {
      await GroupDetailRoute($extra: model).push<void>(context);
      return;
    }

    final joined = await JoinGroupConfirmSheet.show(context);
    if (joined != true || !mounted) return;

    await ref.read(groupsViewModelProvider.notifier).joinGroup(model.id);
    if (!mounted) return;
    await GroupDetailRoute($extra: model).push<void>(context);
  }
}

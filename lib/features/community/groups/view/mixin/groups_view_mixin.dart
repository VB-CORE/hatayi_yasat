import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/groups/provider/groups_view_model.dart';
import 'package:lifeclient/features/community/groups/view/groups_view.dart';
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
}

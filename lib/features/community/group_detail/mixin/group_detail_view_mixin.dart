import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/community/group_detail/group_detail_view.dart';
import 'package:lifeclient/features/community/group_detail/provider/group_detail_state.dart';
import 'package:lifeclient/features/community/group_detail/provider/group_detail_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupDetailViewMixin
    on ConsumerState<GroupDetailView>, AppProviderMixin<GroupDetailView> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(
      groupDetailViewModelProvider(widget.model.id),
      _onGroupChanged,
    );
  }

  void _onGroupChanged(GroupDetailState? previous, GroupDetailState next) {
    if (next.group?.isDeleted != true) return;
    if (!mounted || !context.canPop()) return;

    context.pop();
    appProvider.showSnackbarMessage(
      LocaleKeys.community_groupDetail_details_groupRemoved.tr(),
    );
  }
}

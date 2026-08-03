import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_state.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/group_discussions_view.dart';
import 'package:lifeclient/features/community/widget/content_action_result_handler.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupDiscussionsViewMixin
    on
        ConsumerState<GroupDiscussionsView>,
        AppProviderMixin<GroupDiscussionsView> {
  GroupDiscussionsViewModelProvider get _discussionsNotifier =>
      groupDiscussionsViewModelProvider(widget.model.id);

  @override
  void initState() {
    super.initState();
    ref.listenManual(_discussionsNotifier, _onDiscussionActionResult);
  }

  void _onDiscussionActionResult(
    GroupDiscussionsState? previous,
    GroupDiscussionsState next,
  ) {
    final notifier = ref.read(_discussionsNotifier.notifier);
    unawaited(
      handleContentActionStatus(
        context,
        status: next.status,
        showSnackbar: appProvider.showSnackbarMessage,
        resetStatus: notifier.resetStatus,
      ),
    );
  }

  void openDiscussion(GroupDiscussionModel discussion) {
    unawaited(
      DiscussionDetailRoute(
        $extra: DiscussionDetailArgs(
          group: widget.model,
          discussion: discussion,
        ),
      ).push<void>(context),
    );
  }
}

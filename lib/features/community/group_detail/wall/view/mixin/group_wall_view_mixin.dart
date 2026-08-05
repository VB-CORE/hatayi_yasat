import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/group_wall_view.dart';
import 'package:lifeclient/features/community/widget/content_action_result_handler.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin GroupWallViewMixin
    on ConsumerState<GroupWallView>, AppProviderMixin<GroupWallView> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(
      groupWallViewModelProvider(widget.model.id),
      _onPostActionResult,
    );
  }

  void _onPostActionResult(GroupWallState? previous, GroupWallState next) {
    final notifier = ref.read(
      groupWallViewModelProvider(widget.model.id).notifier,
    );
    unawaited(
      ContentActionResultHandler.handle(
        context,
        status: next.status,
        showSnackbar: appProvider.showSnackbarMessage,
        resetStatus: notifier.resetStatus,
      ),
    );
  }
}

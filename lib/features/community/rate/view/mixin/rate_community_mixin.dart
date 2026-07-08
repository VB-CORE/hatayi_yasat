import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_action_failed_dialog.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_card.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';

mixin RateCommentControllerMixin
    on ConsumerState<RateCard>, AppProviderMixin<RateCard> {
  final TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    commentController.text = widget.initialComment ?? '';
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void onRateStateChanged(RateCommunityState? prev, RateCommunityState next) {
    final notifier = ref.read(
      rateCommunityProviderProvider(widget.esnafId).notifier,
    );
    switch (next.status) {
      case ActionIdle():
      case ActionProcessing():
        return;
      case ActionSucceeded(:final action) when action != RateAction.delete:
        appProvider.showSnackbarMessage(action.succeededMessage);
        widget.onSubmitted?.call();
        notifier.resetStatus();
        return;
      case ActionSucceeded():
        return;
      case ActionFailed(:final action) when action != RateAction.delete:
        unawaited(RateActionFailedDialog.show(context, action.failedMessage));
        notifier.resetStatus();
        return;
      case ActionFailed():
        return;
    }
  }
}

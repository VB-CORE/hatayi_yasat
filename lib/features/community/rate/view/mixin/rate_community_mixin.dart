import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_view_model.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_action_failed_dialog.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_card_sheet.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';

mixin RateCommentControllerMixin
    on ConsumerState<RateCardSheet>, AppProviderMixin<RateCardSheet> {
  final TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    commentController.text = widget.initialComment ?? '';
    ref.listenManual(
      rateCommunityViewModelProvider(widget.placeId),
      onRateStateChanged,
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void onRateStateChanged(RateCommunityState? prev, RateCommunityState next) {
    final notifier = ref.read(
      rateCommunityViewModelProvider(widget.placeId).notifier,
    );
    switch (next.status) {
      case RateActionFailed(:final action) when action != RateAction.delete:
        unawaited(
          RateActionFailedDialog.show(context, action.failedMessageKey.tr()),
        );
        notifier.resetStatus();
      case RateActionSucceeded(:final action) when action != RateAction.delete:
        appProvider.showSnackbarMessage(action.succeededMessageKey.tr());
        widget.onSubmitted?.call();
        notifier.resetStatus();
      case _:
        break;
    }
  }
}

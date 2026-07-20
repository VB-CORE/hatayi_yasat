import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/rate/model/mock_auth.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_view_model.dart';
import 'package:lifeclient/features/community/rate/view/rate_comment_list_view.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_action_failed_dialog.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/login_required_dialog.dart';

mixin RateCommentListViewMixin
    on
        ConsumerState<RateCommentListView>,
        AppProviderMixin<RateCommentListView> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(
      rateCommunityViewModelProvider(widget.placeId),
      onDeleteResult,
    );
  }

  void onDeleteResult(RateCommunityState? prev, RateCommunityState next) {
    final notifier = ref.read(
      rateCommunityViewModelProvider(widget.placeId).notifier,
    );
    switch (next.status) {
      case RateActionSucceeded(:final action) when action == RateAction.delete:
        appProvider.showSnackbarMessage(action.succeededMessageKey.tr());
        notifier.resetStatus();
      case RateActionFailed(:final action) when action == RateAction.delete:
        unawaited(
          RateActionFailedDialog.show(context, action.failedMessageKey.tr()),
        );
        notifier.resetStatus();
      case _:
        break;
    }
  }

  Future<void> onAddCommentPressed({required bool hasVoted}) async {
    if (!widget.isCommentEnabled || hasVoted) return;
    if (!MockAuth.isAuthenticated) {
      await LoginRequiredDialog.show(context);
      return;
    }
    await RateSheetFactory.showRateCard(context, placeId: widget.placeId);
  }
}

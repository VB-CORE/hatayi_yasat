import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/rate/model/mock_auth.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_view_model.dart';
import 'package:lifeclient/features/community/rate/view/rate_comment_list.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_action_failed_dialog.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

mixin RateCommentListMixin
    on ConsumerState<RateCommentList>, AppProviderMixin<RateCommentList> {
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
      case ActionSucceeded(:final action) when action == RateAction.delete:
        appProvider.showSnackbarMessage(action.succeededMessage);
        notifier.resetStatus();
        return;
      case ActionFailed(:final action) when action == RateAction.delete:
        unawaited(RateActionFailedDialog.show(context, action.failedMessage));
        notifier.resetStatus();
        return;
      case ActionIdle():
      case ActionProcessing():
      case ActionSucceeded():
      case ActionFailed():
        return;
    }
  }

  Future<void> onAddCommentPressed({required bool hasVoted}) async {
    if (!widget.isCommentEnabled || hasVoted) return;
    if (!MockAuth.isAuthenticated) {
      await showLoginRequiredDialog(context);
      return;
    }
    await RateSheetFactory.showRateCard(context, placeId: widget.placeId);
  }

  Future<void> showLoginRequiredDialog(BuildContext context) =>
      GeneralTextDialog.show(
        context,
        LocaleKeys.rate_loginRequiredTitle.tr(),
        LocaleKeys.rate_loginRequiredContent.tr(),
        [
          GeneralDialogButton(
            title: LocaleKeys.button_cancel,
            onPressed: () => Navigator.pop(context),
          ),
          GeneralDialogButton(
            title: LocaleKeys.button_login,
            onPressed: () {
              Navigator.pop(context);
              const MainTabRoute().go(context);
            },
          ),
        ],
        backgroundColor: AppColors.bg,
      );
}

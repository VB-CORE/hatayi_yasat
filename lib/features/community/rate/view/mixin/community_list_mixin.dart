import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_action_failed_dialog.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

mixin CommunityListMixin on ConsumerWidget, AppProviderStateMixin {
  void onDeleteResult(
    BuildContext context,
    WidgetRef ref,
    String esnafId,
    RateCommunityState? prev,
    RateCommunityState next,
  ) {
    final notifier = ref.read(rateCommunityProviderProvider(esnafId).notifier);
    switch (next.status) {
      case ActionSucceeded(:final action) when action == RateAction.delete:
        appProvider(ref).showSnackbarMessage(action.succeededMessage);
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
        backgroundColor: context.general.colorScheme.surface,
      );
}

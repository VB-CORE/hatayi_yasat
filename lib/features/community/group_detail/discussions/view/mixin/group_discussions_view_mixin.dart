import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/discussion_detail/model/discussion_detail_args.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_state.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/group_discussions_view.dart';
import 'package:lifeclient/features/community/widget/community_delete_confirm_dialog.dart';
import 'package:lifeclient/features/community/widget/community_options_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

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
    switch (next.status) {
      case DiscussionActionSucceeded(:final action):
        appProvider.showSnackbarMessage(action.succeededMessageKey.tr());
        notifier.resetStatus();
      case DiscussionActionFailed(:final action):
        unawaited(
          GeneralTextDialog.show(
            context,
            LocaleKeys.button_error.tr(),
            action.failedMessageKey.tr(),
            [
              GeneralDialogButton(
                title: LocaleKeys.button_ok,
                onPressed: () => Navigator.pop(context),
              ),
            ],
            backgroundColor: context.general.colorScheme.surface,
          ),
        );
        notifier.resetStatus();
      case _:
        break;
    }
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

  Future<void> onDiscussionLongPress(GroupDiscussionModel discussion) async {
    final notifier = ref.read(_discussionsNotifier.notifier);
    if (!notifier.canDelete(discussion)) return;

    final action = await showModalBottomSheet<CommunityOptionAction>(
      context: context,
      builder: (_) => const CommunityOptionsSheet(),
    );
    if (action != CommunityOptionAction.delete || !mounted) return;

    final isConfirmed = await CommunityDeleteConfirmDialog.show(context);
    if (!isConfirmed) return;

    await notifier.deleteDiscussion(discussion);
  }
}

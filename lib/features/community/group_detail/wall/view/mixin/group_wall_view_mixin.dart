import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_state.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/group_wall_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

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
    switch (next.status) {
      case PostActionSucceeded(:final action):
        appProvider.showSnackbarMessage(action.succeededMessageKey.tr());
        notifier.resetStatus();
      case PostActionFailed(:final action):
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
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/community/provider/content_action_status.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

final class ContentActionResultHandler {
  const ContentActionResultHandler._();

  static Future<void> handle(
    BuildContext context, {
    required ContentActionStatus status,
    required void Function(String message) showSnackbar,
    required VoidCallback resetStatus,
  }) async {
    switch (status) {
      case ContentActionSucceeded(:final messageKey):
        showSnackbar(messageKey.tr());
        resetStatus();
      case ContentActionFailed(:final messageKey):
        await GeneralTextDialog.show<void>(
          context,
          LocaleKeys.button_error.tr(),
          messageKey.tr(),
          [
            GeneralDialogButton(
              title: LocaleKeys.button_ok,
              onPressed: () => Navigator.pop(context),
            ),
          ],
          backgroundColor: context.general.colorScheme.surface,
        );
        resetStatus();
      case _:
        break;
    }
  }
}

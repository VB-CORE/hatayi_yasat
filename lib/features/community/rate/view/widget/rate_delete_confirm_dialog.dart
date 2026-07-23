import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

final class RateDeleteConfirmDialog {
  const RateDeleteConfirmDialog._();

  static Future<bool> show(BuildContext context) async {
    final isConfirmed = await GeneralTextDialog.show<bool>(
      context,
      LocaleKeys.rate_deleteConfirmTitle.tr(),
      LocaleKeys.rate_deleteConfirmContent.tr(),
      [
        GeneralDialogButton(
          title: LocaleKeys.button_cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        GeneralDialogButton(
          title: LocaleKeys.button_iAmSure,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
      backgroundColor: context.general.colorScheme.surface,
    );
    return isConfirmed ?? false;
  }
}

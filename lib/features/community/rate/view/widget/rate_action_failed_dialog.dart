import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

final class RateActionFailedDialog {
  const RateActionFailedDialog._();

  static Future<void> show(BuildContext context, String content) =>
      GeneralTextDialog.show(
        context,
        LocaleKeys.rate_actionFailedTitle.tr(),
        content,
        [
          GeneralDialogButton(
            title: LocaleKeys.button_ok,
            onPressed: () => Navigator.pop(context),
          ),
        ],
        backgroundColor: context.general.colorScheme.surface,
      );
}

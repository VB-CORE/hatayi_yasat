import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

final class LoginRequiredDialog {
  const LoginRequiredDialog._();

  /// Warns the user that the action needs an account and, on confirmation,
  /// sends them to [LoginRoute].
  static Future<void> show(BuildContext context) async {
    final goLogin = await GeneralTextDialog.show<bool>(
      context,
      LocaleKeys.dialog_loginRequiredTitle.tr(),
      LocaleKeys.dialog_loginRequiredContent.tr(),
      [
        GeneralDialogButton(
          title: LocaleKeys.button_cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        GeneralDialogButton(
          title: LocaleKeys.button_login,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
      backgroundColor: context.general.colorScheme.surface,
    );
    if (!(goLogin ?? false) || !context.mounted) return;
    const LoginRoute().go(context);
  }
}

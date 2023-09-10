import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class NotificationSnackBar extends SnackBar {
  NotificationSnackBar({
    required String message,
    required ValueChanged<bool> isOpenListen,
    super.key,
  }) : super(
          content: Text(message),
          action: SnackBarAction(
            label: LocaleKeys.notification_snackbarButtonText.tr(),
            onPressed: () {
              isOpenListen.call(true);
            },
          ),
        );
}

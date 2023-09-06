import 'package:flutter/material.dart';

class NotificationSnackBar extends SnackBar {
  NotificationSnackBar({
    required String message,
    required ValueChanged<bool> isOpenListen,
    super.key,
  }) : super(
          content: Text(message),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () {
              isOpenListen.call(true);
            },
          ),
        );
}

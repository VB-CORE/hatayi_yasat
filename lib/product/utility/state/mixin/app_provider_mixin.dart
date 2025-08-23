import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/notification_type.dart';
import 'package:lifeclient/product/utility/state/items/app_provider_state.dart';
import 'package:lifeclient/product/widget/snackbar/error_snack_bar.dart';
import 'package:lifeclient/product/widget/snackbar/notification_snack_bar.dart';
import 'package:lifeclient/sub_feature/notification_navigate/notification_navigate_parse.dart';

mixin AppProviderOperationMixin on Notifier<AppProviderState> {
  final CustomService customService = FirebaseService();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackbarMessage(String message) {
    scaffoldMessengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(ErrorSnackBar(message: message));
  }

  void showSnackbarNotification(
    String message,
    String id,
    BuildContext context,
    NotificationType type,
  ) {
    scaffoldMessengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(
        NotificationSnackBar(
          message: message,
          isOpenListen: (value) async {
            if (!value) return;

            await NotificationNavigateParse(context).makeWithType(
              id: id,
              type: type,
            );
          },
        ),
      );
  }
}

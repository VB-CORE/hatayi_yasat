import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/model/enum/notification_type.dart';
import 'package:vbaseproject/product/package/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/utility/state/items/app_provider_state.dart';
import 'package:vbaseproject/product/widget/snackbar/error_snack_bar.dart';
import 'package:vbaseproject/product/widget/snackbar/notification_snack_bar.dart';

mixin AppProviderOperationMixin on StateNotifier<AppProviderState> {
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
          isOpenListen: (value) {
            if (!value) return;
            switch (type) {
              case NotificationType.campaigns:
                MessagingNavigate.instance.detailModelCampaignCheckAndNavigate(
                  context: context,
                  id: id,
                  customService: customService,
                );
              case NotificationType.project:
                MessagingNavigate.instance.detailModelCheckAndNavigate(
                  context: context,
                  id: id,
                  customService: customService,
                );
              case NotificationType.news:
                MessagingNavigate.instance.detailModelNewsCheckAndNavigate(
                  context: context,
                  id: id,
                  customService: customService,
                );
              case NotificationType.advertise:
              // we don't navigate
            }
          },
        ),
      );
  }
}

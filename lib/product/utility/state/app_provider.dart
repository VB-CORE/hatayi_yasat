import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/model/enum/notification_type.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/widget/snackbar/error_snack_bar.dart';
import 'package:vbaseproject/product/widget/snackbar/notification_snack_bar.dart';

class AppProvider extends StateNotifier<AppProviderState> {
  AppProvider() : super(const AppProviderState());

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static final provider =
      StateNotifierProvider<AppProvider, AppProviderState>((_) {
    return AppProvider();
  });

  Future<void> init() async => checkDeviceId();
  final CustomService customService = FirebaseService();
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
            if (type == NotificationType.campaigns) {
              MessagingNavigate.instance.detailModelCampaignCheckAndNavigate(
                context: context,
                id: id,
                customService: customService,
              );
            } else {
              MessagingNavigate.instance.detailModelCheckAndNavigate(
                context: context,
                id: id,
                customService: customService,
              );
            }
          },
        ),
      );
  }

  Future<void> checkDeviceId() async {
    try {
      final deviceID =
          kIsWeb ? kWeb : await DeviceUtility.instance.getUniqueDeviceId();
      state = state.copyWith(deviceID: deviceID);
    } catch (e) {
      state = state.copyWith(deviceID: kWeb);
    }
  }
}

@immutable
class AppProviderState extends Equatable {
  const AppProviderState({
    this.deviceID,
  });

  final String? deviceID;

  @override
  List<Object?> get props => [deviceID];

  AppProviderState copyWith({
    String? deviceID,
  }) {
    return AppProviderState(
      deviceID: deviceID ?? this.deviceID,
    );
  }
}

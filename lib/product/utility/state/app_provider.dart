// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/snackbar/error_snack_bar.dart';

class AppProvider extends StateNotifier<AppProviderState> {
  AppProvider() : super(const AppProviderState());

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static final provider =
      StateNotifierProvider<AppProvider, AppProviderState>((_) {
    return AppProvider();
  });

  Future<void> init() async => checkDeviceId();

  void showSnackbarMessage(String message) {
    scaffoldMessengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(ErrorSnackBar(message: message));
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

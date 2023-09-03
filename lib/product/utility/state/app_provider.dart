// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/service/firebase_service.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

class AppProvider extends StateNotifier<AppProviderState> {
  AppProvider() : super(const AppProviderState());

  final FirebaseService firebaseService = FirebaseService();

  static final provider =
      StateNotifierProvider<AppProvider, AppProviderState>((_) {
    return AppProvider();
  });

  Future<void> init(BuildContext context) async {
    await Future.wait([checkDeviceId()]);
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

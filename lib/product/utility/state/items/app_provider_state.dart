import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppProviderState extends Equatable {
  const AppProviderState({
    this.deviceID = '',
    this.theme = ThemeMode.light,
  });

  final String deviceID;
  final ThemeMode theme;

  @override
  List<Object> get props => [deviceID, theme];

  AppProviderState copyWith({
    String? deviceID,
    ThemeMode? theme,
  }) {
    return AppProviderState(
      deviceID: deviceID ?? this.deviceID,
      theme: theme ?? this.theme,
    );
  }
}

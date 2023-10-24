import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/model/enum/redirect_tabs.dart';

@immutable
class AppProviderState extends Equatable {
  const AppProviderState({
    this.deviceID = '',
    this.theme = ThemeMode.light,
    this.redirectionPage,
  });

  final String deviceID;
  final ThemeMode theme;

  final RedirectTabs? redirectionPage;

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

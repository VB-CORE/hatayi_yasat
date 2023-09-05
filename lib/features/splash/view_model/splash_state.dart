import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class SplashState extends Equatable {
  const SplashState({
    this.isOperationStaring = false,
    this.isNeedToForceUpdate = false,
    this.isConnectedToInternet = false,
  });

  final bool isOperationStaring;
  final bool isNeedToForceUpdate;
  final bool isConnectedToInternet;

  @override
  List<Object?> get props =>
      [isOperationStaring, isNeedToForceUpdate, isConnectedToInternet];

  SplashState copyWith({
    bool? isOperationStaring,
    bool? isNeedToForceUpdate,
    bool? isConnectedToInternet,
  }) {
    return SplashState(
      isOperationStaring: isOperationStaring ?? this.isOperationStaring,
      isNeedToForceUpdate: isNeedToForceUpdate ?? this.isNeedToForceUpdate,
      isConnectedToInternet:
          isConnectedToInternet ?? this.isConnectedToInternet,
    );
  }
}

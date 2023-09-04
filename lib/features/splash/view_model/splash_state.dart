import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class SplashState extends Equatable {
  const SplashState({
    this.isOperationStaring = false,
    this.isNeedToForceUpdate = false,
  });

  final bool isOperationStaring;
  final bool isNeedToForceUpdate;

  @override
  List<Object?> get props => [isOperationStaring, isNeedToForceUpdate];

  SplashState copyWith({
    bool? isOperationStaring,
    bool? isNeedToForceUpdate,
  }) {
    return SplashState(
      isOperationStaring: isOperationStaring ?? this.isOperationStaring,
      isNeedToForceUpdate: isNeedToForceUpdate ?? this.isNeedToForceUpdate,
    );
  }
}

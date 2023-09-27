import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class SplashState extends Equatable {
  const SplashState({
    this.isOperationStaring = false,
    this.isNeedToForceUpdate = false,
    this.isConnectedToInternet = true,
    this.isNeedToOnBoard = false,
  });

  final bool isOperationStaring;
  final bool isNeedToForceUpdate;
  final bool isConnectedToInternet;
  final bool isNeedToOnBoard;

  @override
  List<Object> get props => [
        isOperationStaring,
        isNeedToForceUpdate,
        isConnectedToInternet,
        isNeedToOnBoard,
      ];

  SplashState copyWith({
    bool? isOperationStaring,
    bool? isNeedToForceUpdate,
    bool? isConnectedToInternet,
    bool? isNeedToOnBoard,
  }) {
    return SplashState(
      isOperationStaring: isOperationStaring ?? this.isOperationStaring,
      isNeedToForceUpdate: isNeedToForceUpdate ?? this.isNeedToForceUpdate,
      isConnectedToInternet:
          isConnectedToInternet ?? this.isConnectedToInternet,
      isNeedToOnBoard: isNeedToOnBoard ?? this.isNeedToOnBoard,
    );
  }
}

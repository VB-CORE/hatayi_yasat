import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class SplashState extends Equatable {
  const SplashState({
    this.isOperationStaring = false,
    this.isNeedToForceUpdate = false,
    this.isConnectedToInternet = true,
    this.isNeedToOnBoard = false,
    this.isError = false,
  });

  final bool isOperationStaring;
  final bool isNeedToForceUpdate;
  final bool isConnectedToInternet;
  final bool isNeedToOnBoard;
  final bool isError;

  @override
  List<Object> get props => [
        isOperationStaring,
        isNeedToForceUpdate,
        isConnectedToInternet,
        isNeedToOnBoard,
        isError,
      ];

  SplashState copyWith({
    bool? isOperationStaring,
    bool? isNeedToForceUpdate,
    bool? isConnectedToInternet,
    bool? isNeedToOnBoard,
    bool? isError,
  }) {
    return SplashState(
      isOperationStaring: isOperationStaring ?? this.isOperationStaring,
      isNeedToForceUpdate: isNeedToForceUpdate ?? this.isNeedToForceUpdate,
      isConnectedToInternet:
          isConnectedToInternet ?? this.isConnectedToInternet,
      isNeedToOnBoard: isNeedToOnBoard ?? this.isNeedToOnBoard,
      isError: isError ?? this.isError,
    );
  }
}

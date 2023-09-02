import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class SplashState extends Equatable {
  const SplashState({this.isOperationStaring = false});

  final bool isOperationStaring;

  @override
  List<Object?> get props => [isOperationStaring];

  SplashState copyWith({
    bool? isOperationStaring,
  }) {
    return SplashState(
      isOperationStaring: isOperationStaring ?? this.isOperationStaring,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class GroupWallState extends Equatable {
  const GroupWallState({this.isSubmitting = false, this.isError = false});

  final bool isSubmitting;
  final bool isError;

  @override
  List<Object?> get props => [isSubmitting, isError];

  GroupWallState copyWith({bool? isSubmitting, bool? isError}) {
    return GroupWallState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class CreateGroupState extends Equatable {
  const CreateGroupState({this.isSubmitting = false, this.isError = false});

  final bool isSubmitting;
  final bool isError;

  @override
  List<Object?> get props => [isSubmitting, isError];

  CreateGroupState copyWith({bool? isSubmitting, bool? isError}) {
    return CreateGroupState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
    );
  }
}

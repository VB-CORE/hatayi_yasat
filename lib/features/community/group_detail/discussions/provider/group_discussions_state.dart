import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class GroupDiscussionsState extends Equatable {
  const GroupDiscussionsState({
    this.isSubmitting = false,
    this.isError = false,
  });

  final bool isSubmitting;
  final bool isError;

  @override
  List<Object?> get props => [isSubmitting, isError];

  GroupDiscussionsState copyWith({bool? isSubmitting, bool? isError}) {
    return GroupDiscussionsState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
    );
  }
}

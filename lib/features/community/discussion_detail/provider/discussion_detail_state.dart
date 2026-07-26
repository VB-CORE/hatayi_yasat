import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class DiscussionDetailState extends Equatable {
  const DiscussionDetailState({
    this.isSubmitting = false,
    this.isError = false,
  });

  final bool isSubmitting;
  final bool isError;

  @override
  List<Object?> get props => [isSubmitting, isError];

  DiscussionDetailState copyWith({bool? isSubmitting, bool? isError}) {
    return DiscussionDetailState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
    );
  }
}

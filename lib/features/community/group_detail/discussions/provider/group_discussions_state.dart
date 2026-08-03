import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/features/community/provider/content_action_status.dart';

@immutable
final class GroupDiscussionsState extends Equatable {
  const GroupDiscussionsState({
    this.isSubmitting = false,
    this.isError = false,
    this.status = const ContentActionIdle(),
  });

  final bool isSubmitting;
  final bool isError;
  final ContentActionStatus status;

  bool get isProcessing => status is ContentActionProcessing;

  @override
  List<Object?> get props => [isSubmitting, isError, status];

  GroupDiscussionsState copyWith({
    bool? isSubmitting,
    bool? isError,
    ContentActionStatus? status,
  }) {
    return GroupDiscussionsState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
      status: status ?? this.status,
    );
  }
}

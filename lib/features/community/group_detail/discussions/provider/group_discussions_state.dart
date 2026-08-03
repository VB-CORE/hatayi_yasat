import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum DiscussionAction {
  delete;

  String get failedMessageKey => switch (this) {
    DiscussionAction.delete =>
      LocaleKeys.community_groupDetail_discussions_discussionDeleteFailedContent,
  };

  String get succeededMessageKey => switch (this) {
    DiscussionAction.delete =>
      LocaleKeys.community_groupDetail_discussions_discussionDeleteSuccessMessage,
  };
}

sealed class DiscussionActionStatus extends Equatable {
  const DiscussionActionStatus();
}

final class DiscussionActionIdle extends DiscussionActionStatus {
  const DiscussionActionIdle();
  @override
  List<Object?> get props => [];
}

final class DiscussionActionProcessing extends DiscussionActionStatus {
  const DiscussionActionProcessing(this.action);
  final DiscussionAction action;
  @override
  List<Object?> get props => [action];
}

final class DiscussionActionSucceeded extends DiscussionActionStatus {
  const DiscussionActionSucceeded(this.action);
  final DiscussionAction action;
  @override
  List<Object?> get props => [action];
}

final class DiscussionActionFailed extends DiscussionActionStatus {
  const DiscussionActionFailed(this.action);
  final DiscussionAction action;
  @override
  List<Object?> get props => [action];
}

@immutable
final class GroupDiscussionsState extends Equatable {
  const GroupDiscussionsState({
    this.isSubmitting = false,
    this.isError = false,
    this.status = const DiscussionActionIdle(),
  });

  final bool isSubmitting;
  final bool isError;
  final DiscussionActionStatus status;

  bool get isProcessing => status is DiscussionActionProcessing;

  @override
  List<Object?> get props => [isSubmitting, isError, status];

  GroupDiscussionsState copyWith({
    bool? isSubmitting,
    bool? isError,
    DiscussionActionStatus? status,
  }) {
    return GroupDiscussionsState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
      status: status ?? this.status,
    );
  }
}

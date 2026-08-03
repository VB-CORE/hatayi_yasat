import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum EntryAction {
  delete;

  String get failedMessageKey => switch (this) {
    EntryAction.delete =>
      LocaleKeys.community_groupDetail_discussions_entryDeleteFailedContent,
  };

  String get succeededMessageKey => switch (this) {
    EntryAction.delete =>
      LocaleKeys.community_groupDetail_discussions_entryDeleteSuccessMessage,
  };
}

sealed class EntryActionStatus extends Equatable {
  const EntryActionStatus();
}

final class EntryActionIdle extends EntryActionStatus {
  const EntryActionIdle();
  @override
  List<Object?> get props => [];
}

final class EntryActionProcessing extends EntryActionStatus {
  const EntryActionProcessing(this.action);
  final EntryAction action;
  @override
  List<Object?> get props => [action];
}

final class EntryActionSucceeded extends EntryActionStatus {
  const EntryActionSucceeded(this.action);
  final EntryAction action;
  @override
  List<Object?> get props => [action];
}

final class EntryActionFailed extends EntryActionStatus {
  const EntryActionFailed(this.action);
  final EntryAction action;
  @override
  List<Object?> get props => [action];
}

@immutable
final class DiscussionDetailState extends Equatable {
  const DiscussionDetailState({
    this.isSubmitting = false,
    this.isError = false,
    this.status = const EntryActionIdle(),
  });

  final bool isSubmitting;
  final bool isError;
  final EntryActionStatus status;

  bool get isProcessing => status is EntryActionProcessing;

  @override
  List<Object?> get props => [isSubmitting, isError, status];

  DiscussionDetailState copyWith({
    bool? isSubmitting,
    bool? isError,
    EntryActionStatus? status,
  }) {
    return DiscussionDetailState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
      status: status ?? this.status,
    );
  }
}

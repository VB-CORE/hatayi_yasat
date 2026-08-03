import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum PostAction {
  delete;

  String get failedMessageKey => switch (this) {
    PostAction.delete => LocaleKeys.community_groupDetail_wall_deleteFailedContent,
  };

  String get succeededMessageKey => switch (this) {
    PostAction.delete => LocaleKeys.community_groupDetail_wall_deleteSuccessMessage,
  };
}

sealed class PostActionStatus extends Equatable {
  const PostActionStatus();
}

final class PostActionIdle extends PostActionStatus {
  const PostActionIdle();
  @override
  List<Object?> get props => [];
}

final class PostActionProcessing extends PostActionStatus {
  const PostActionProcessing(this.action);
  final PostAction action;
  @override
  List<Object?> get props => [action];
}

final class PostActionSucceeded extends PostActionStatus {
  const PostActionSucceeded(this.action);
  final PostAction action;
  @override
  List<Object?> get props => [action];
}

final class PostActionFailed extends PostActionStatus {
  const PostActionFailed(this.action);
  final PostAction action;
  @override
  List<Object?> get props => [action];
}

@immutable
final class GroupWallState extends Equatable {
  const GroupWallState({
    this.isSubmitting = false,
    this.isError = false,
    this.status = const PostActionIdle(),
  });

  final bool isSubmitting;
  final bool isError;
  final PostActionStatus status;

  bool get isProcessing => status is PostActionProcessing;

  @override
  List<Object?> get props => [isSubmitting, isError, status];

  GroupWallState copyWith({
    bool? isSubmitting,
    bool? isError,
    PostActionStatus? status,
  }) {
    return GroupWallState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
      status: status ?? this.status,
    );
  }
}

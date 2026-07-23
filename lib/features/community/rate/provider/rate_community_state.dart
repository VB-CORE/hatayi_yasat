import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum RateAction {
  create,
  update,
  delete;

  String get failedMessageKey => switch (this) {
    RateAction.create => LocaleKeys.rate_submitFailedContent,
    RateAction.update => LocaleKeys.rate_editCommentFailedContent,
    RateAction.delete => LocaleKeys.rate_deleteFailedContent,
  };

  String get succeededMessageKey => switch (this) {
    RateAction.create => LocaleKeys.rate_commentAdded,
    RateAction.update => LocaleKeys.rate_editCommentSuccessMessage,
    RateAction.delete => LocaleKeys.rate_deleteSuccessMessage,
  };
}

sealed class RateActionStatus extends Equatable {
  const RateActionStatus();
}

final class RateActionIdle extends RateActionStatus {
  const RateActionIdle();
  @override
  List<Object?> get props => [];
}

final class RateActionSucceeded extends RateActionStatus {
  const RateActionSucceeded(this.action);
  final RateAction action;
  @override
  List<Object?> get props => [action];
}

final class RateActionProcessing extends RateActionStatus {
  const RateActionProcessing(this.action);
  final RateAction action;
  @override
  List<Object?> get props => [action];
}

final class RateActionFailed extends RateActionStatus {
  const RateActionFailed(this.action);
  final RateAction action;
  @override
  List<Object?> get props => [action];
}

final class RateCommunityState extends Equatable {
  const RateCommunityState({
    this.vote,
    this.isLoading = false,
    this.isSignInRequired = false,
    this.isError = false,
    this.draftScore = 0,
    this.retryToken = 0,
    this.showAllComments = false,
    this.status = const RateActionIdle(),
  });

  final RateModel? vote;
  final bool isLoading;
  final bool isSignInRequired;
  final bool isError;
  final int draftScore;
  final int retryToken;
  final bool showAllComments;
  final RateActionStatus status;

  bool get hasVoted => vote != null;
  bool get isBusy => isLoading || isProcessing;
  double get value => (hasVoted ? vote!.score : draftScore).toDouble();
  bool get isProcessing => status is RateActionProcessing;
  bool get canCreateVote => !hasVoted && draftScore > 0 && !isBusy && !isError;
  bool get canEditVote => hasVoted && !isBusy;

  RateCommunityState copyWith({
    RateModel? vote,
    int? draftScore,
    bool? isLoading,
    bool? isSignInRequired,
    bool? isError,
    int? retryToken,
    bool? showAllComments,
    bool clearVote = false,
    RateActionStatus? status,
  }) => RateCommunityState(
    vote: clearVote ? null : (vote ?? this.vote),
    draftScore: draftScore ?? this.draftScore,
    isLoading: isLoading ?? this.isLoading,
    isSignInRequired: isSignInRequired ?? this.isSignInRequired,
    isError: isError ?? this.isError,
    retryToken: retryToken ?? this.retryToken,
    showAllComments: showAllComments ?? this.showAllComments,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    vote,
    draftScore,
    isLoading,
    isSignInRequired,
    isError,
    retryToken,
    showAllComments,
    status,
  ];
}

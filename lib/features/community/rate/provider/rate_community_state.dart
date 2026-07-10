import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum RateAction {
  create,
  update,
  delete;

  String get failedMessage => switch (this) {
    RateAction.create => LocaleKeys.rate_submitFailedContent.tr(),
    RateAction.update => LocaleKeys.rate_editCommentFailedContent.tr(),
    RateAction.delete => LocaleKeys.rate_deleteFailedContent.tr(),
  };

  String get succeededMessage => switch (this) {
    RateAction.create => LocaleKeys.rate_commentAdded.tr(),
    RateAction.update => LocaleKeys.rate_editCommentSuccessMessage.tr(),
    RateAction.delete => LocaleKeys.rate_deleteSuccessMessage.tr(),
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
    this.comments = const [],
    this.isLoading = false,
    this.draftRate = 0,
    this.status = const RateActionIdle(),
  });

  final RateModel? vote;
  final List<RateModel> comments;
  final bool isLoading;
  final double draftRate;
  final RateActionStatus status;

  bool get hasVoted => vote != null;
  bool get isBusy => isLoading || isProcessing;
  double get value => hasVoted ? vote!.rate : draftRate;
  bool get isProcessing => status is RateActionProcessing;
  bool get canSubmit =>
      ((vote?.rate ?? 0) > 0 || draftRate > 0) && !isProcessing;

  RateCommunityState copyWith({
    RateModel? vote,
    List<RateModel>? comments,
    double? draftRate,
    bool? isLoading,
    bool clearVote = false,
    RateActionStatus? status,
  }) => RateCommunityState(
    vote: clearVote ? null : (vote ?? this.vote),
    comments: comments ?? this.comments,
    draftRate: draftRate ?? this.draftRate,
    isLoading: isLoading ?? this.isLoading,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    vote,
    comments,
    draftRate,
    isLoading,
    status,
  ];
}

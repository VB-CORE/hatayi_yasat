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
    RateAction.create => LocaleKeys.rate_rateThankYou.tr(),
    RateAction.update => LocaleKeys.rate_editCommentSuccessMessage.tr(),
    RateAction.delete => LocaleKeys.rate_deleteSuccessMessage.tr(),
  };
}

sealed class RateActionStatus extends Equatable {
  const RateActionStatus();
}

final class ActionIdle extends RateActionStatus {
  const ActionIdle();
  @override
  List<Object?> get props => [];
}

final class ActionSucceeded extends RateActionStatus {
  const ActionSucceeded(this.action);
  final RateAction action;
  @override
  List<Object?> get props => [action];
}

final class ActionProcessing extends RateActionStatus {
  const ActionProcessing(this.action);
  final RateAction action;
  @override
  List<Object?> get props => [action];
}

final class ActionFailed extends RateActionStatus {
  const ActionFailed(this.action);
  final RateAction action;
  @override
  List<Object?> get props => [action];
}

final class RateCommunityState extends Equatable {
  const RateCommunityState({
    this.vote,
    this.comments = const [],
    this.isLoading = false,
    this.isError = false,
    this.draftRate = 0,
    this.status = const ActionIdle(),
  });

  final RateModel? vote;
  final List<RateModel> comments;
  final bool isLoading;
  final bool isError;
  final double draftRate;
  final RateActionStatus status;

  bool get isReadOnly => vote != null;
  double get value => isReadOnly ? vote!.rate : draftRate;
  bool get isProcessing => status is ActionProcessing;
  bool get isBusy => isLoading || isProcessing;
  bool get canSubmit =>
      ((vote?.rate ?? 0) > 0 || draftRate > 0) && !isProcessing;

  RateCommunityState copyWith({
    RateModel? vote,
    List<RateModel>? comments,
    double? draftRate,
    bool? isLoading,
    bool? isError,
    bool clearVote = false,
    RateActionStatus? status,
  }) => RateCommunityState(
    vote: clearVote ? null : (vote ?? this.vote),
    comments: comments ?? this.comments,
    draftRate: draftRate ?? this.draftRate,
    isLoading: isLoading ?? this.isLoading,
    isError: isError ?? this.isError,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    vote,
    comments,
    draftRate,
    isLoading,
    isError,
    status,
  ];
}

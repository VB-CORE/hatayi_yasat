import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';

final class RateCommunityState extends Equatable {
  const RateCommunityState({
    this.vote,
    this.comments = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.isError = false,
    this.draftRate = 0,
    this.isActionError = false,
  });
  final RateModel? vote;
  final List<RateModel> comments;
  final bool isLoading;
  final bool isSubmitting;
  final double draftRate;
  final bool isError;
  final bool isActionError;

  bool get isReadOnly => vote != null;
  double get value => isReadOnly ? vote!.rate : draftRate;
  bool get canSubmit => vote == null && draftRate > 0 && !isSubmitting;
  @override
  List<Object?> get props => [
    vote,
    comments,
    draftRate,
    isLoading,
    isSubmitting,
    isError,
    isActionError,
  ];

  RateCommunityState copyWith({
    RateModel? vote,
    List<RateModel>? comments,
    double? draftRate,
    bool? isLoading,
    bool? isSubmitting,
    bool? isError,
    bool clearVote = false,
    bool? isActionError,
  }) => RateCommunityState(
    vote: clearVote ? null : (vote ?? this.vote),

    comments: comments ?? this.comments,
    draftRate: draftRate ?? this.draftRate,
    isLoading: isLoading ?? this.isLoading,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    isError: isError ?? this.isError,
    isActionError: isActionError ?? this.isActionError,
  );
}

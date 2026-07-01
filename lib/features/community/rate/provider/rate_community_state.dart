import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';

final class RateCommunityState extends Equatable {
  const RateCommunityState({
    this.vote,
    this.isLoading = false,
    this.isSubmitting = false,
    this.draftRate = 0,
  });
  final RateModel? vote;
  final bool isLoading;
  final bool isSubmitting;
  final double draftRate;
  bool get isReadOnly => vote != null;
  double get value => vote?.rate ?? 0;
  bool get canSubmit => vote == null && draftRate > 0 && !isSubmitting;
  @override
  List<Object?> get props => [vote, isLoading, isSubmitting, draftRate];
  RateCommunityState copyWith({
    RateModel? vote,
    bool? isLoading,
    bool? isSubmitting,
    double? draftRate,
  }) => RateCommunityState(
    vote: vote ?? this.vote,
    isLoading: isLoading ?? this.isLoading,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    draftRate: draftRate ?? this.draftRate,
  );
}

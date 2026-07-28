import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_review_filter.dart';

final class MerchantReviewsState extends Equatable {
  const MerchantReviewsState({
    this.reviews = const [],
    this.filter = MerchantReviewFilter.pending,
    this.isFetching = false,
    this.isError = false,
    this.replyingVoterUid,
  });

  final List<RateModel> reviews;
  final MerchantReviewFilter filter;
  final bool isFetching;
  final bool isError;

  final String? replyingVoterUid;

  bool get isSubmitting => replyingVoterUid != null;

  List<RateModel> get comments => reviews
      .where((review) => review.comment?.trim().isNotEmpty ?? false)
      .toList();

  List<RateModel> get pendingReviews =>
      comments.where((review) => !review.hasMerchantReply).toList();

  List<RateModel> get answeredReviews =>
      comments.where((review) => review.hasMerchantReply).toList();

  List<RateModel> get visibleReviews => switch (filter) {
    MerchantReviewFilter.pending => pendingReviews,
    MerchantReviewFilter.all => comments,
    MerchantReviewFilter.answered => answeredReviews,
  };

  double get averageScore {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<int>(0, (sum, review) => sum + review.score);
    return total / reviews.length;
  }

  MerchantReviewsState copyWith({
    List<RateModel>? reviews,
    MerchantReviewFilter? filter,
    bool? isFetching,
    bool? isError,
    String? replyingVoterUid,
    bool clearReplyingVoterUid = false,
  }) {
    return MerchantReviewsState(
      reviews: reviews ?? this.reviews,
      filter: filter ?? this.filter,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
      replyingVoterUid: clearReplyingVoterUid
          ? null
          : replyingVoterUid ?? this.replyingVoterUid,
    );
  }

  @override
  List<Object?> get props => [
    reviews,
    filter,
    isFetching,
    isError,
    replyingVoterUid,
  ];
}

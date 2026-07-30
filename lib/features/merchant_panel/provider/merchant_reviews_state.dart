import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_review_filter.dart';

final class MerchantReviewsState extends Equatable {
  const MerchantReviewsState({
    this.filter = MerchantReviewFilter.pending,
    this.isError = false,
    this.replyingVoterUid,
  });

  final MerchantReviewFilter filter;
  final bool isError;
  final String? replyingVoterUid;

  bool get isSubmitting => replyingVoterUid != null;

  MerchantReviewsState copyWith({
    MerchantReviewFilter? filter,
    bool? isError,
    String? replyingVoterUid,
    bool clearReplyingVoterUid = false,
  }) {
    return MerchantReviewsState(
      filter: filter ?? this.filter,
      isError: isError ?? this.isError,
      replyingVoterUid: clearReplyingVoterUid
          ? null
          : replyingVoterUid ?? this.replyingVoterUid,
    );
  }

  @override
  List<Object?> get props => [filter, isError, replyingVoterUid];
}

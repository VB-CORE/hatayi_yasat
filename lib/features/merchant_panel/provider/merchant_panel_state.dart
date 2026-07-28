import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';

final class MerchantPanelState extends Equatable {
  const MerchantPanelState({
    this.store,
    this.reviews = const [],
    this.isFetching = false,
    this.isError = false,
    this.isUnauthorized = false,
  });

  final StoreModel? store;
  final List<RateModel> reviews;
  final bool isFetching;
  final bool isError;

  final bool isUnauthorized;

  int get visitCount => store?.visitCount ?? 0;

  List<RateModel> get comments => reviews
      .where((review) => review.comment?.trim().isNotEmpty ?? false)
      .toList();

  int get pendingReplyCount =>
      comments.where((review) => !review.hasMerchantReply).length;

  double get averageScore {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<int>(0, (sum, review) => sum + review.score);
    return total / reviews.length;
  }

  MerchantPanelState copyWith({
    StoreModel? store,
    List<RateModel>? reviews,
    bool? isFetching,
    bool? isError,
    bool? isUnauthorized,
  }) {
    return MerchantPanelState(
      store: store ?? this.store,
      reviews: reviews ?? this.reviews,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
      isUnauthorized: isUnauthorized ?? this.isUnauthorized,
    );
  }

  @override
  List<Object?> get props => [
    store,
    reviews,
    isFetching,
    isError,
    isUnauthorized,
  ];
}

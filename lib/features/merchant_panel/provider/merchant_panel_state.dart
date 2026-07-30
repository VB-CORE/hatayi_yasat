import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class MerchantPanelState extends Equatable {
  const MerchantPanelState({
    this.store,
    this.hasPendingReply = false,
    this.isFetching = false,
    this.isError = false,
    this.isUnauthorized = false,
  });

  final StoreModel? store;
  final bool hasPendingReply;
  final bool isFetching;
  final bool isError;
  final bool isUnauthorized;

  int get visitCount => store?.visitCount ?? 0;

  int get reviewCount => store?.ratingCount ?? 0;

  MerchantPanelState copyWith({
    StoreModel? store,
    bool? hasPendingReply,
    bool? isFetching,
    bool? isError,
    bool? isUnauthorized,
  }) {
    return MerchantPanelState(
      store: store ?? this.store,
      hasPendingReply: hasPendingReply ?? this.hasPendingReply,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
      isUnauthorized: isUnauthorized ?? this.isUnauthorized,
    );
  }

  @override
  List<Object?> get props => [
    store,
    hasPendingReply,
    isFetching,
    isError,
    isUnauthorized,
  ];
}

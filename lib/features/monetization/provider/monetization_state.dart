import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';

@immutable
final class MonetizationState extends Equatable {
  const MonetizationState({
    this.coupons = const [],
    this.isFetching = false,
    this.isSubmitting = false,
    this.isError = false,
  });

  final List<DiscountCouponModel> coupons;
  final bool isFetching;
  final bool isSubmitting;
  final bool isError;

  List<DiscountCouponModel> get activeCoupons =>
      coupons.where((coupon) => !coupon.isInactive).toList();

  List<DiscountCouponModel> get inactiveCoupons =>
      coupons.where((coupon) => coupon.isInactive).toList();

  @override
  List<Object?> get props => [
    coupons,
    isFetching,
    isSubmitting,
    isError,
  ];

  MonetizationState copyWith({
    List<DiscountCouponModel>? coupons,
    bool? isFetching,
    bool? isSubmitting,
    bool? isError,
  }) {
    return MonetizationState(
      coupons: coupons ?? this.coupons,
      isFetching: isFetching ?? this.isFetching,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isError: isError ?? this.isError,
    );
  }
}

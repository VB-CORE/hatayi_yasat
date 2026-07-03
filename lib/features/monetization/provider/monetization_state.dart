import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';

@immutable
final class MonetizationState extends Equatable {
  const MonetizationState({
    this.coupons = const [],
    this.isFetching = false,
    this.isError = false,
  });

  final List<DiscountCouponModel> coupons;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [coupons, isFetching, isError];

  MonetizationState copyWith({
    List<DiscountCouponModel>? coupons,
    bool? isFetching,
    bool? isError,
  }) {
    return MonetizationState(
      coupons: coupons ?? this.coupons,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}

import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_mock.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/features/monetization/provider/monetization_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monetization_view_model.g.dart';

@riverpod
final class MonetizationViewModel extends _$MonetizationViewModel
    with ProjectDependencyMixin {
  @override
  MonetizationState build() => const MonetizationState();

  Future<void> fetchCoupons() async {
    state = state.copyWith(isFetching: true, isError: false);

    try {
      final coupons = DiscountCouponMock.mockDiscountCoupons;
      state = state.copyWith(coupons: coupons, isFetching: false);
    } on Object {
      state = state.copyWith(isFetching: false, isError: true);
    }
  }

  Future<void> addCoupon(DiscountCouponModel coupon) async {
    try {
      final added = DiscountCouponMock.add(coupon);
      state = state.copyWith(coupons: [...state.coupons, added]);
    } on Object {
      state = state.copyWith(isError: true);
    }
  }

  Future<void> updateCoupon(DiscountCouponModel coupon) async {
    try {
      final updated = DiscountCouponMock.update(coupon);
      if (updated == null) {
        state = state.copyWith(isError: true);
        return;
      }

      state = state.copyWith(
        coupons: state.coupons
            .map(
              (item) => item.documentId == updated.documentId ? updated : item,
            )
            .toList(),
      );
    } on Object {
      state = state.copyWith(isError: true);
    }
  }

  Future<void> deleteCoupon(String documentId) async {
    try {
      final deleted = DiscountCouponMock.delete(documentId);
      if (!deleted) {
        state = state.copyWith(isError: true);
        return;
      }

      state = state.copyWith(
        coupons: state.coupons
            .where((item) => item.documentId != documentId)
            .toList(),
      );
    } on Object {
      state = state.copyWith(isError: true);
    }
  }
}

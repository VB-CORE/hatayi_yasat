import 'dart:async';

import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/features/monetization/provider/monetization_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monetization_view_model.g.dart';

@riverpod
final class MonetizationViewModel extends _$MonetizationViewModel
    with ProjectDependencyMixin {
  String? get _storeId => ref.read(authViewModelProvider).user?.application?.id;
  String? get _merchantUid => ref.read(authViewModelProvider).user?.uid;

  @override
  MonetizationState build() {
    return const MonetizationState(isFetching: true);
  }

  Future<void> fetchCoupons() async {
    state = state.copyWith(isFetching: true, isError: false);

    final result = await firestoreService.getList<DiscountCouponModel>(
      model: DiscountCouponModel(),
      path: CollectionPaths.coupons,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        coupons: data.where((coupon) => coupon.storeId == _storeId).toList(),
        isFetching: false,
        isError: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }

  Future<bool> addCoupon({
    required String desc,
    required int rate,
    required DateTime expiresAt,
    int? usageLimit,
  }) async {
    if (_storeId.ext.isNullOrEmpty) return false;
    if (_merchantUid.ext.isNullOrEmpty) return false;
    if (state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, isError: false);

    final now = DateTime.now();

    final coupon = DiscountCouponModel(
      storeId: _storeId,
      merchantUid: _merchantUid,
      desc: desc,
      ratio: rate,
      expiresAt: expiresAt,
      usageLimit: usageLimit,
      createdAt: now,
      updatedAt: now,
    );

    final result = await firestoreService.add<DiscountCouponModel>(
      model: coupon,
      path: CollectionPaths.coupons,
    );

    if (!result.isSuccess) {
      state = state.copyWith(isSubmitting: false, isError: true);
      return false;
    }

    state = state.copyWith(
      coupons: [
        ...state.coupons,
        coupon.copyWith(documentId: result.dataOrNull),
      ],
      isSubmitting: false,
    );
    return true;
  }

  Future<bool> updateCoupon({
    required DiscountCouponModel coupon,
    required String desc,
    required int rate,
    required DateTime expiresAt,
    int? usageLimit,
  }) async {
    if (coupon.documentId.isEmpty || state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, isError: false);

    final now = DateTime.now();
    final updated = coupon.copyWith(
      desc: desc,
      ratio: rate,
      expiresAt: expiresAt,
      usageLimit: usageLimit,
      clearUsageLimit: usageLimit == null,
      updatedAt: now,
    );

    final result = await firestoreService.updateFields(
      path: CollectionPaths.coupons,
      documentId: coupon.documentId,
      fields: DiscountCouponModel.updateFields(
        desc: desc,
        ratio: rate,
        expiresAt: expiresAt,
        usageLimit: usageLimit,
        clearUsageLimit: usageLimit == null,
      ),
    );

    if (!result.isSuccess) {
      state = state.copyWith(isSubmitting: false, isError: true);
      return false;
    }

    state = state.copyWith(
      coupons: [
        for (final item in state.coupons)
          if (item.documentId == coupon.documentId) updated else item,
      ],
      isSubmitting: false,
    );
    return true;
  }

  Future<bool> deleteCoupon(DiscountCouponModel coupon) async {
    if (state.isSubmitting || coupon.documentId.isEmpty) return false;

    state = state.copyWith(isSubmitting: true, isError: false);
    final result = await firestoreService.delete<DiscountCouponModel>(
      path: CollectionPaths.coupons,
      model: coupon,
    );

    if (result.isSuccess) {
      state = state.copyWith(
        coupons: state.coupons
            .where((item) => item.documentId != coupon.documentId)
            .toList(),
        isSubmitting: false,
      );
      return true;
    }

    state = state.copyWith(isSubmitting: false, isError: true);
    return false;
  }
}

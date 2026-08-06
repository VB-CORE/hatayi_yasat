import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/monetization/data/coupon_redemption_model.dart';
import 'package:lifeclient/features/monetization/data/coupon_redemption_path.dart';
import 'package:lifeclient/features/monetization/provider/coupon_redeem_state.dart';
import 'package:lifeclient/features/monetization/provider/monetization_view_model.dart';
import 'package:lifeclient/features/sub_feature/user_qr/model/user_qr_payload.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coupon_redeem_view_model.g.dart';

@riverpod
final class CouponRedeemViewModel extends _$CouponRedeemViewModel
    with ProjectDependencyMixin {
  static const String _usageCountField = 'usageCount';

  FirestoreCollectionPath get _redemptions => CouponRedemptionPath(couponId);

  CouponModel? get _coupon {
    for (final item in ref.read(monetizationViewModelProvider).coupons) {
      if (item.documentId == couponId) return item;
    }
    return null;
  }

  @override
  CouponRedeemState build(String couponId) => const CouponRedeemState();

  void reset() => state = const CouponRedeemState();

  Future<void> redeemFromQr(String? rawQrValue) async {
    if (state.isProcessing) return;

    final userUid = UserQrPayload.decode(rawQrValue);
    if (userUid == null) {
      _fail(CouponRedeemError.invalidQr);
      return;
    }

    final coupon = _coupon;
    if (coupon == null) {
      _fail(CouponRedeemError.failed);
      return;
    }
    if (coupon.isExpired) {
      _fail(CouponRedeemError.expired);
      return;
    }
    if (coupon.isUsageLimitReached) {
      _fail(CouponRedeemError.usageLimitReached);
      return;
    }

    state = state.copyWith(isProcessing: true);

    final existing = await firestoreService
        .getSingleData<CouponRedemptionModel>(
          model: const CouponRedemptionModel(),
          path: _redemptions,
          id: userUid,
        );

    switch (existing) {
      case FirebaseFailure(:final error):
        analyticsService.recordError(
          error,
          StackTrace.current,
          reason: 'couponRedeem.lookup($couponId)',
        );
        _fail(CouponRedeemError.failed, isProcessing: false);
        return;
      case FirebaseSuccess(:final data):
        if (data != null) {
          state = state.copyWith(
            isProcessing: false,
            result: CouponRedeemAlreadyUsed(data.redeemedAt),
          );
          _logFailure('already_used');
          return;
        }
    }

    await _grant(coupon, userUid);
  }

  Future<void> _grant(CouponModel coupon, String userUid) async {
    final merchantUid = ref.read(authViewModelProvider).user?.uid ?? '';
    final redemption = CouponRedemptionModel(
      userUid: userUid,
      merchantUid: merchantUid,
      storeId: coupon.storeId ?? '',
      redeemedAt: DateTime.now(),
    );

    final result = await firestoreService.batchWrite((batch) {
      batch
        ..set(_redemptions.collection.doc(userUid), redemption.toJson())
        ..update(CollectionPaths.coupons.collection.doc(couponId), {
          _usageCountField: FieldValue.increment(1),
        });
    });

    if (!result.isSuccess) {
      await _resolveFailure(userUid);
      return;
    }

    await ref.read(monetizationViewModelProvider.notifier).fetchCoupons();

    state = state.copyWith(
      isProcessing: false,
      result: CouponRedeemGranted(redemption),
    );

    analyticsService.logEvent(
      AnalyticsEvent.couponRedeem,
      parameters: {
        AnalyticsParameter.couponId: couponId,
        AnalyticsParameter.storeId: redemption.storeId,
      },
    );
  }

  Future<void> _resolveFailure(String userUid) async {
    final existing = await firestoreService
        .getSingleData<CouponRedemptionModel>(
          model: const CouponRedemptionModel(),
          path: _redemptions,
          id: userUid,
        );

    state = switch (existing) {
      FirebaseSuccess(:final data) when data != null => state.copyWith(
        isProcessing: false,
        result: CouponRedeemAlreadyUsed(data.redeemedAt),
      ),
      _ => state.copyWith(
        isProcessing: false,
        result: const CouponRedeemFailed(CouponRedeemError.failed),
      ),
    };

    _logFailure(
      state.result is CouponRedeemAlreadyUsed
          ? 'already_used'
          : CouponRedeemError.failed.name,
    );
  }

  void _fail(CouponRedeemError error, {bool? isProcessing}) {
    state = state.copyWith(
      isProcessing: isProcessing,
      result: CouponRedeemFailed(error),
    );
    _logFailure(error.name);
  }

  void _logFailure(String reason) {
    analyticsService.logEvent(
      AnalyticsEvent.couponRedeemFailed,
      parameters: {
        AnalyticsParameter.couponId: couponId,
        AnalyticsParameter.reason: reason,
      },
    );
  }
}

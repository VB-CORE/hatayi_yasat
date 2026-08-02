import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/monetization/data/coupon_redemption_model.dart';

sealed class CouponRedeemResult extends Equatable {
  const CouponRedeemResult();

  @override
  List<Object?> get props => [];
}

final class CouponRedeemIdle extends CouponRedeemResult {
  const CouponRedeemIdle();
}

final class CouponRedeemGranted extends CouponRedeemResult {
  const CouponRedeemGranted(this.redemption);

  final CouponRedemptionModel redemption;

  @override
  List<Object?> get props => [redemption];
}

final class CouponRedeemAlreadyUsed extends CouponRedeemResult {
  const CouponRedeemAlreadyUsed(this.redeemedAt);

  final DateTime? redeemedAt;

  @override
  List<Object?> get props => [redeemedAt];
}

enum CouponRedeemError { invalidQr, expired, usageLimitReached, failed }

final class CouponRedeemFailed extends CouponRedeemResult {
  const CouponRedeemFailed(this.error);

  final CouponRedeemError error;

  @override
  List<Object?> get props => [error];
}

final class CouponRedeemState extends Equatable {
  const CouponRedeemState({
    this.result = const CouponRedeemIdle(),
    this.isProcessing = false,
  });

  final CouponRedeemResult result;
  final bool isProcessing;

  bool get isIdle => result is CouponRedeemIdle;

  CouponRedeemState copyWith({
    CouponRedeemResult? result,
    bool? isProcessing,
  }) {
    return CouponRedeemState(
      result: result ?? this.result,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  @override
  List<Object?> get props => [result, isProcessing];
}

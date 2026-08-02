import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'coupon_redemption_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class CouponRedemptionModel
    extends BaseFirebaseModel<CouponRedemptionModel>
    with EquatableMixin {
  const CouponRedemptionModel({
    this.userUid = '',
    this.merchantUid = '',
    this.storeId = '',
    this.redeemedAt,
  });

  final String userUid;
  final String merchantUid;
  final String storeId;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? redeemedAt;

  @override
  String get documentId => userUid;

  @override
  Map<String, dynamic> toJson() => _$CouponRedemptionModelToJson(this);

  @override
  CouponRedemptionModel fromJson(Map<String, dynamic> json) =>
      _$CouponRedemptionModelFromJson(json);

  @override
  CouponRedemptionModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    final data = json.data();
    if (data == null) return this;
    return fromJson(data).copyWith(userUid: json.id);
  }

  CouponRedemptionModel copyWith({
    String? userUid,
    String? merchantUid,
    String? storeId,
    DateTime? redeemedAt,
  }) => CouponRedemptionModel(
    userUid: userUid ?? this.userUid,
    merchantUid: merchantUid ?? this.merchantUid,
    storeId: storeId ?? this.storeId,
    redeemedAt: redeemedAt ?? this.redeemedAt,
  );

  @override
  List<Object?> get props => [userUid, merchantUid, storeId, redeemedAt];
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'discount_coupon_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class DiscountCouponModel extends BaseFirebaseModel<DiscountCouponModel>
    with Equatable
    implements BaseFirebaseConvert<DiscountCouponModel> {
  DiscountCouponModel({
    this.storeId,
    this.merchantUid,
    this.desc,
    this.ratio,
    this.expiresAt,
    this.usageCount = 0,
    this.usageLimit,
    this.createdAt,
    this.updatedAt,
    this.documentId = '',
    this.isDeleted = false,
  });

  final String? storeId;
  final String? merchantUid;
  final String? desc;
  final int? ratio;
  final int? usageCount;
  final int? usageLimit;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? expiresAt;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  final DateTime? updatedAt;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String documentId;

  final bool isDeleted;

  bool get isExpired =>
      expiresAt != null && expiresAt!.isBefore(DateTime.now());

  bool get isUsageLimitReached {
    final limit = usageLimit;
    if (limit == null) return false;
    return (usageCount ?? 0) >= limit;
  }

  bool get isInactive => isExpired || isUsageLimitReached;

  @override
  Map<String, dynamic> toJson() => _$DiscountCouponModelToJson(this);

  @override
  List<Object?> get props => [
    storeId,
    merchantUid,
    desc,
    ratio,
    expiresAt,
    usageCount,
    usageLimit,
    createdAt,
    updatedAt,
    documentId,
    isDeleted,
  ];

  DiscountCouponModel copyWith({
    String? storeId,
    String? merchantUid,
    String? desc,
    int? ratio,
    DateTime? expiresAt,
    int? usageCount,
    int? usageLimit,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? documentId,
    bool? isDeleted,
  }) {
    return DiscountCouponModel(
      storeId: storeId ?? this.storeId,
      merchantUid: merchantUid ?? this.merchantUid,
      desc: desc ?? this.desc,
      ratio: ratio ?? this.ratio,
      expiresAt: expiresAt ?? this.expiresAt,
      usageCount: usageCount ?? this.usageCount,
      usageLimit: usageLimit ?? this.usageLimit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      documentId: documentId ?? this.documentId,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  DiscountCouponModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    if (json.data() == null) return this;

    return _$DiscountCouponModelFromJson(json.data()!).copyWith(
      documentId: json.id,
    );
  }

  @override
  DiscountCouponModel fromJson(Map<String, dynamic> json) {
    return _$DiscountCouponModelFromJson(json);
  }
}

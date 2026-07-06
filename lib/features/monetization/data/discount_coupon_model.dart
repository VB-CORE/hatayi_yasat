import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'discount_coupon_model.g.dart';

// Life Shared CampaignModel referans alındı
@JsonSerializable()
final class DiscountCouponModel extends BaseFirebaseModel<DiscountCouponModel>
    with EquatableMixin
    implements BaseFirebaseConvert<DiscountCouponModel> {
  DiscountCouponModel({
    this.storeId,
    this.desc,
    this.discountRate,
    this.storeName,
    this.createdBy,
    this.expiresAt,
    this.usageCount,
    this.usageLimit,
    this.createdAt,
    this.updatedAt,
    this.documentId = '',
  });

  final String? storeId;
  final String? desc;
  final int? discountRate;
  final String? storeName;
  final String? createdBy;
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
    desc,
    discountRate,
    storeName,
    createdBy,
    expiresAt,
    usageCount,
    usageLimit,
    createdAt,
    updatedAt,
  ];

  DiscountCouponModel copyWith({
    String? storeId,
    String? desc,
    int? discountRate,
    String? storeName,
    String? createdBy,
    DateTime? expiresAt,
    int? usageCount,
    int? usageLimit,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? documentId,
  }) {
    return DiscountCouponModel(
      storeId: storeId ?? this.storeId,
      desc: desc ?? this.desc,
      discountRate: discountRate ?? this.discountRate,
      storeName: storeName ?? this.storeName,
      createdBy: createdBy ?? this.createdBy,
      expiresAt: expiresAt ?? this.expiresAt,
      usageCount: usageCount ?? this.usageCount,
      usageLimit: usageLimit ?? this.usageLimit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      documentId: documentId ?? this.documentId,
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

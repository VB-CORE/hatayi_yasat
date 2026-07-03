import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'discount_coupon_model.g.dart';

@immutable
@JsonSerializable()
final class DiscountCouponModel extends BaseFirebaseModel<DiscountCouponModel>
    with EquatableMixin {
  DiscountCouponModel({
    this.code,
    this.name,
    this.discountRate,
    this.storeId,
    this.storeName,
    this.createdBy,
    this.expiresAt,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.documentId = '',
  });

  final String? code;
  final String? name;
  final int? discountRate;
  final String? storeId;
  final String? storeName;
  final String? createdBy;
  final bool? isActive;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? expiresAt;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String documentId;

  @override
  Map<String, dynamic> toJson() => _$DiscountCouponModelToJson(this);

  @override
  DiscountCouponModel fromJson(Map<String, dynamic> json) {
    return _$DiscountCouponModelFromJson(json);
  }

  @override
  DiscountCouponModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    final data = json.data();
    if (data == null) return this;

    return _$DiscountCouponModelFromJson(data).copyWith(
      documentId: json.id,
    );
  }

  DiscountCouponModel copyWith({
    String? documentId,
    String? code,
    String? name,
    int? discountRate,
    String? storeId,
    String? storeName,
    String? createdBy,
    bool? isActive,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DiscountCouponModel(
      documentId: documentId ?? this.documentId,
      code: code ?? this.code,
      name: name ?? this.name,
      discountRate: discountRate ?? this.discountRate,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      createdBy: createdBy ?? this.createdBy,
      isActive: isActive ?? this.isActive,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    documentId,
    code,
    name,
    discountRate,
    storeId,
    storeName,
    createdBy,
    isActive,
    expiresAt,
    createdAt,
    updatedAt,
  ];
}

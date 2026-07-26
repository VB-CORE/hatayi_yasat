// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountCouponModel _$DiscountCouponModelFromJson(Map<String, dynamic> json) =>
    DiscountCouponModel(
      storeId: json['storeId'] as String?,
      desc: json['desc'] as String?,
      discountRate: (json['discountRate'] as num?)?.toInt(),
      storeName: json['storeName'] as String?,
      createdBy: json['createdBy'] as String?,
      expiresAt: FirebaseTimeParse.datetimeFromTimestamp(json['expiresAt']),
      usageCount: (json['usageCount'] as num?)?.toInt(),
      usageLimit: (json['usageLimit'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
    );

Map<String, dynamic> _$DiscountCouponModelToJson(
  DiscountCouponModel instance,
) => <String, dynamic>{
  'storeId': instance.storeId,
  'desc': instance.desc,
  'discountRate': instance.discountRate,
  'storeName': instance.storeName,
  'createdBy': instance.createdBy,
  'usageCount': instance.usageCount,
  'usageLimit': instance.usageLimit,
  'expiresAt': FirebaseTimeParse.dateTimeToTimestamp(instance.expiresAt),
  'createdAt': FirebaseTimeParse.dateTimeToTimestamp(instance.createdAt),
  'updatedAt': FirebaseTimeParse.dateTimeToTimestamp(instance.updatedAt),
};

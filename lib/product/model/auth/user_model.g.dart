// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  uid: json['uid'] as String? ?? '',
  email: json['email'] as String? ?? '',
  displayName: json['displayName'] as String? ?? '',
  roleType: (json['roleType'] as num?)?.toInt() ?? 2,
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  rates:
      (json['rates'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  photoUrl: json['photoUrl'] as String?,
  merchantStoreId: json['merchantStoreId'] as String?,
  fcmToken: json['fcmToken'] as String?,
  updatedAt: FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'displayName': instance.displayName,
  'roleType': instance.roleType,
  'permissions': instance.permissions,
  'rates': instance.rates,
  'photoUrl': ?instance.photoUrl,
  'merchantStoreId': ?instance.merchantStoreId,
  'fcmToken': ?instance.fcmToken,
};

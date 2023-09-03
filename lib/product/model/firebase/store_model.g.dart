// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      name: json['name'] as String,
      owner: json['owner'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      townCode: json['townCode'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isApproved: json['isApproved'] as bool,
      deviceID: json['deviceID'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'owner': instance.owner,
      'description': instance.description,
      'address': instance.address,
      'phone': instance.phone,
      'images': instance.images,
      'townCode': instance.townCode,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isApproved': instance.isApproved,
      'deviceID': instance.deviceID,
    };

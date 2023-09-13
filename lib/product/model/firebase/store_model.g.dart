// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      name: json['name'] as String,
      owner: json['owner'] as String,
      address: json['address'] as String?,
      phone: json['phone'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      townCode: json['townCode'] as int,
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : FirebaseTimeParser.datetimeFromTimestamp(
              json['createdAt'] as Timestamp?),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : FirebaseTimeParser.datetimeFromTimestamp(
              json['updatedAt'] as Timestamp?),
      isApproved: json['isApproved'] as bool,
      deviceID: json['deviceID'] as String?,
      id: json['id'] as String? ?? '',
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
      'createdAt': FirebaseTimeParser.dateTimeToTimestamp(instance.createdAt),
      'updatedAt': FirebaseTimeParser.dateTimeToTimestamp(instance.updatedAt),
      'isApproved': instance.isApproved,
      'deviceID': instance.deviceID,
      'id': instance.id,
    };

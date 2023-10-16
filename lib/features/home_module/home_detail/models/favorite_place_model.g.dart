// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePlaceModel _$FavoritePlaceModelFromJson(Map<String, dynamic> json) =>
    FavoritePlaceModel(
      name: json['name'] as String,
      address: json['address'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      townCode: json['townCode'] as int,
    );

Map<String, dynamic> _$FavoritePlaceModelToJson(FavoritePlaceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'townCode': instance.townCode,
      'address': instance.address,
      'images': instance.images,
    };

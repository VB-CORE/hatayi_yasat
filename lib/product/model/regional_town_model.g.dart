// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regional_town_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionalTownModel _$RegionalTownModelFromJson(Map<String, dynamic> json) =>
    RegionalTownModel(
      documentId: json['documentId'] as String? ?? '',
      cityId: json['cityId'] as String? ?? '',
      towns: (json['towns'] as List<dynamic>?)
              ?.map((e) =>
                  RegionalTownSubItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RegionalTownModelToJson(RegionalTownModel instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'cityId': instance.cityId,
      'towns': instance.towns,
    };

RegionalTownSubItem _$RegionalTownSubItemFromJson(Map<String, dynamic> json) =>
    RegionalTownSubItem(
      code: (json['code'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$RegionalTownSubItemToJson(
        RegionalTownSubItem instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

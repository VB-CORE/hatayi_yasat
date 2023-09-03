// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'town_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TownModel _$TownModelFromJson(Map<String, dynamic> json) => TownModel(
      code: json['code'] as int?,
      name: json['name'] as String?,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$TownModelToJson(TownModel instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'id': instance.id,
    };

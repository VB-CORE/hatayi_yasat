// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourism_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourismMapModel _$TourismMapModelFromJson(Map<String, dynamic> json) =>
    TourismMapModel(
      name: json['name'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$TourismMapModelToJson(TourismMapModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

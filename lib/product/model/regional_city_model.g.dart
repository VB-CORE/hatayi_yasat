// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regional_city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionalCityModel _$RegionalCityModelFromJson(Map<String, dynamic> json) =>
    RegionalCityModel(
      initial: json['initial'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      documentId: json['documentId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      location: json['location'] == null
          ? const GeoPoint(0, 0)
          : FirebaseCustomParser.geoPointFromJson(json['location'] as GeoPoint),
    );

Map<String, dynamic> _$RegionalCityModelToJson(RegionalCityModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'initial': instance.initial,
      'description': instance.description,
      'location': FirebaseCustomParser.geoPointToJson(instance.location),
      'documentId': instance.documentId,
    };

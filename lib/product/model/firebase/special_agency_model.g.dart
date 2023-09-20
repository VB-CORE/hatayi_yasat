// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special_agency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialAgencyModel _$SpecialAgencyModelFromJson(Map<String, dynamic> json) =>
    SpecialAgencyModel(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['adress'] as String?,
      latLong: json['latlong'] == null
          ? AppConstants.hatayLatLong
          : SpecialAgencyModel._fromJsonGeoPoint(json['latlong'] as GeoPoint),
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$SpecialAgencyModelToJson(SpecialAgencyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'adress': instance.address,
      'latlong': SpecialAgencyModel._toJsonGeoPoint(instance.latLong),
      'id': instance.id,
    };

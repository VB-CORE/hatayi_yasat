import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vbaseproject/product/model/base/base_firebase_model.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

part 'special_agency_model.g.dart';

@JsonSerializable()
class SpecialAgencyModel extends BaseFirebaseConvert<SpecialAgencyModel>
    with EquatableMixin {
  SpecialAgencyModel({
    this.name,
    this.phone,
    this.address,
    this.latLong = AppConstants.hatayLatLong,
    this.id = '',
  });

  factory SpecialAgencyModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialAgencyModelFromJson(json);

  final String? name;
  final String? phone;
  @JsonKey(name: 'adress')
  final String? address;
  @JsonKey(
    fromJson: _fromJsonGeoPoint,
    toJson: _toJsonGeoPoint,
    name: 'latlong',
  )
  GeoPoint latLong;
  @override
  final String id;

  Map<String, dynamic> toJson() => _$SpecialAgencyModelToJson(this);

  static Map<String, dynamic> _toJsonGeoPoint(GeoPoint geoPoint) {
    return {'latitude': geoPoint.latitude, 'longitude': geoPoint.longitude};
  }

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  @override
  List<Object?> get props => [
        name,
        address,
        phone,
        latLong,
        id,
      ];

  @override
  SpecialAgencyModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    if (json.data() == null) return this;
    return SpecialAgencyModel.fromJson(
      json.data()!.map((key, value) => MapEntry(key.trim(), value)),
    ).copyWith(
      id: json.id,
    );
  }

  SpecialAgencyModel copyWith({
    String? name,
    String? phone,
    String? address,
    GeoPoint? latLong,
    String? id,
  }) {
    return SpecialAgencyModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      latLong: latLong ?? this.latLong,
      id: id ?? this.id,
    );
  }
}

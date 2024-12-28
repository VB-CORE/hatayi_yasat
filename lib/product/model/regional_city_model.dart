import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/mixin/firebase/firebase_geo_parser.dart';

part 'regional_city_model.g.dart';

@JsonSerializable(explicitToJson: true)
final class RegionalCityModel extends BaseFirebaseModel<RegionalCityModel>
    with EquatableMixin, BaseDropDownModel {
  const RegionalCityModel({
    this.initial = false,
    this.description = '',
    this.documentId = '',
    this.name = '',
    this.location = const GeoPoint(0, 0),
  });

  const RegionalCityModel.empty()
      : this(
          initial: false,
          description: '',
          documentId: '',
          name: '',
          location: const GeoPoint(0, 0),
        );

  final String name;
  final bool initial;
  final String description;

  @JsonKey(
    fromJson: FirebaseCustomParser.geoPointFromJson,
    toJson: FirebaseCustomParser.geoPointToJson,
  )
  final GeoPoint location;
  @override
  final String documentId;

  @override
  Map<String, dynamic> toJson() => _$RegionalCityModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        initial,
        description,
        location,
        documentId,
      ];

  RegionalCityModel copyWith({
    String? name,
    bool? initial,
    String? description,
    GeoPoint? location,
    String? documentId,
  }) {
    return RegionalCityModel(
      name: name ?? this.name,
      initial: initial ?? this.initial,
      description: description ?? this.description,
      location: location ?? this.location,
      documentId: documentId ?? this.documentId,
    );
  }

  @override
  RegionalCityModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data();
    if (data == null) return const RegionalCityModel.empty();

    return _$RegionalCityModelFromJson(data).copyWith(
      documentId: json.id,
    );
  }

  @override
  RegionalCityModel fromJson(Map<String, dynamic> json) {
    return _$RegionalCityModelFromJson(json);
  }

  @override
  String get displayName => name;
}

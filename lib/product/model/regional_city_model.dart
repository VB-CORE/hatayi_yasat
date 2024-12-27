import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/src/core/base_firebase_model.dart';

part 'regional_city_model.g.dart';

@JsonSerializable()
final class RegionalCityModel extends BaseFirebaseModel<RegionalCityModel>
    with EquatableMixin {
  const RegionalCityModel({
    this.initial = false,
    this.description = '',
    this.documentId = '',
    this.name = '',
  });

  const RegionalCityModel.empty()
      : this(
          initial: false,
          description: '',
          documentId: '',
          name: '',
        );

  final String name;
  final bool initial;
  final String description;
  @override
  final String documentId;

  @override
  Map<String, dynamic> toJson() => _$RegionalCityModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        initial,
        description,
        documentId,
      ];

  RegionalCityModel copyWith({
    String? name,
    bool? initial,
    String? description,
    String? documentId,
  }) {
    return RegionalCityModel(
      name: name ?? this.name,
      initial: initial ?? this.initial,
      description: description ?? this.description,
      documentId: documentId ?? this.documentId,
    );
  }

  @override
  RegionalCityModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    if (json.data() == null) return this;

    return _$RegionalCityModelFromJson(json.data()!).copyWith(
      documentId: json.id,
    );
  }

  @override
  RegionalCityModel fromJson(Map<String, dynamic> json) {
    return _$RegionalCityModelFromJson(json);
  }
}

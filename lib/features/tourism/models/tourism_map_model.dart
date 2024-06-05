import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'tourism_map_model.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
final class TourismMapModel extends BaseFirebaseModel<TourismMapModel>
    with EquatableMixin
    implements BaseFirebaseConvert<TourismMapModel> {
  const TourismMapModel({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.documentId = '',
  });

  factory TourismMapModel.empty() {
    return const TourismMapModel(
      latitude: 0,
      longitude: 0,
      description: '',
      name: '',
    );
  }

  final String name;
  final String description;
  final double latitude;
  final double longitude;

  LatLng get position => LatLng(latitude, longitude);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String documentId;

  @override
  List<Object?> get props => [
        name,
        description,
        latitude,
        longitude,
        documentId,
      ];

  TourismMapModel copyWith({
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    String? documentId,
  }) {
    return TourismMapModel(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
      documentId: documentId ?? this.documentId,
    );
  }

  @override
  TourismMapModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data();
    if (data == null) return this;
    return _$TourismMapModelFromJson(json.data()!).copyWith(
      documentId: json.id,
    );
  }

  @override
  TourismMapModel fromJson(Map<String, dynamic> json) =>
      _$TourismMapModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TourismMapModelToJson(this);
}

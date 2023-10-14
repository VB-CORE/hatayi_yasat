import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'favorite_place_model.g.dart';

@JsonSerializable()
final class FavoritePlaceModel extends BaseFirebaseModel<FavoritePlaceModel>
    with EquatableMixin {
  const FavoritePlaceModel({required this.name, this.documentId = ''});

  factory FavoritePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritePlaceModelFromJson(json);
  final String name;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String documentId;

  @override
  FavoritePlaceModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    if (json.data() == null) return this;

    return _$FavoritePlaceModelFromJson(json.data()!)
        .copyWith(documentId: json.id);
  }

  @override
  FavoritePlaceModel fromJson(Map<String, dynamic> json) =>
      _$FavoritePlaceModelFromJson(json);

  @override
  List<Object?> get props => [name];

  @override
  Map<String, dynamic> toJson() => _$FavoritePlaceModelToJson(this);

  FavoritePlaceModel copyWith({String? name, String? documentId}) {
    return FavoritePlaceModel(
      name: name ?? this.name,
      documentId: documentId ?? this.documentId,
    );
  }
}

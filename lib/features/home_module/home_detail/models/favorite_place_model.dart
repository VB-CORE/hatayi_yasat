import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/feature/cache/hive/hive_type_id.dart';

part 'favorite_place_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeId.favoritePlace)
final class FavoritePlaceModel extends BaseFirebaseModel<FavoritePlaceModel>
    with EquatableMixin {
  const FavoritePlaceModel({
    required this.name,
    required this.address,
    required this.images,
    required this.townCode,
    this.documentId = '',
  });

  factory FavoritePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritePlaceModelFromJson(json);

  @HiveField(0)
  final String name;
  @HiveField(1)
  final int townCode;
  @HiveField(2)
  final String? address;
  @HiveField(3)
  final List<String> images;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(4)
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

  FavoritePlaceModel copyWith({
    String? name,
    String? documentId,
    int? townCode,
    String? address,
    List<String>? images,
  }) {
    return FavoritePlaceModel(
      name: name ?? this.name,
      documentId: documentId ?? this.documentId,
      address: address ?? this.address,
      images: images ?? this.images,
      townCode: townCode ?? this.townCode,
    );
  }
}

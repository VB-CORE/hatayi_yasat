import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_category_model.dart';
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
    required this.description,
    required this.deviceID,
    required this.phone,
    required this.owner,
    required this.isApproved,
    required this.updatedAt,
    required this.createdAt,
    this.category,
    this.documentId = '',
  });

  factory FavoritePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritePlaceModelFromJson(json);

  factory FavoritePlaceModel.fromStore(StoreModel store) {
    return FavoritePlaceModel(
      documentId: store.documentId,
      isApproved: store.isApproved,
      description: store.description,
      category: FavoritePlaceCategoryModel.fromCategory(store.category),
      createdAt: store.createdAt,
      updatedAt: store.updatedAt,
      townCode: store.townCode,
      deviceID: store.deviceID,
      address: store.address,
      images: store.images,
      phone: store.phone,
      owner: store.owner,
      name: store.name,
    );
  }

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final String owner;
  @HiveField(3)
  final String? deviceID;
  @HiveField(4)
  final String? address;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final int townCode;
  @HiveField(7)
  final bool isApproved;
  @HiveField(8)
  final List<String> images;
  @HiveField(9)
  final FavoritePlaceCategoryModel? category;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  @HiveField(10)
  final DateTime? createdAt;
  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
    defaultValue: DateTime.now,
  )
  @HiveField(11)
  final DateTime? updatedAt;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(12)
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
  List<Object?> get props => [
        name,
        owner,
        description,
        address,
        townCode,
        documentId,
        createdAt,
      ];

  @override
  Map<String, dynamic> toJson() => _$FavoritePlaceModelToJson(this);

  FavoritePlaceModel copyWith({
    String? name,
    String? documentId,
    int? townCode,
    String? address,
    List<String>? images,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deviceID,
    String? phone,
    String? owner,
    bool? isApproved,
    FavoritePlaceCategoryModel? category,
  }) {
    return FavoritePlaceModel(
      name: name ?? this.name,
      documentId: documentId ?? this.documentId,
      address: address ?? this.address,
      images: images ?? this.images,
      townCode: townCode ?? this.townCode,
      description: description ?? this.description,
      deviceID: deviceID ?? this.deviceID,
      phone: phone ?? this.phone,
      owner: owner ?? this.owner,
      isApproved: isApproved ?? this.isApproved,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

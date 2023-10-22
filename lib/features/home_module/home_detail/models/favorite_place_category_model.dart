// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/feature/cache/hive/hive_type_id.dart';

part 'favorite_place_category_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeId.favoriteCategory)
final class FavoritePlaceCategoryModel extends CategoryModel {
  FavoritePlaceCategoryModel({
    required this.name,
    required this.value,
    this.documentId = '',
  }) : super(name: name, value: value);

  FavoritePlaceCategoryModel.empty() : this(name: '', value: 0);

  factory FavoritePlaceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritePlaceCategoryModelFromJson(json);

  factory FavoritePlaceCategoryModel.fromCategory(CategoryModel? category) {
    if (category == null) return FavoritePlaceCategoryModel.empty();

    return FavoritePlaceCategoryModel(
      name: category.name,
      value: category.value,
      documentId: category.documentId,
    );
  }

  @override
  FavoritePlaceCategoryModel fromJson(Map<String, dynamic> json) =>
      FavoritePlaceCategoryModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FavoritePlaceCategoryModelToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @HiveField(0)
  final String documentId;

  @override
  @HiveField(1)
  final String name;

  @override
  @HiveField(2)
  final int value;

  @override
  List<Object?> get props => [name, value];
}

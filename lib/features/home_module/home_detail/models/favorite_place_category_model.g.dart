// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_place_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritePlaceCategoryModelAdapter
    extends TypeAdapter<FavoritePlaceCategoryModel> {
  @override
  final int typeId = 2;

  @override
  FavoritePlaceCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritePlaceCategoryModel(
      name: fields[1] as String,
      value: fields[2] as int,
      documentId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritePlaceCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.documentId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritePlaceCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePlaceCategoryModel _$FavoritePlaceCategoryModelFromJson(
        Map<String, dynamic> json) =>
    FavoritePlaceCategoryModel(
      name: json['name'] as String,
      value: json['value'] as int,
    );

Map<String, dynamic> _$FavoritePlaceCategoryModelToJson(
        FavoritePlaceCategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

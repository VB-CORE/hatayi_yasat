// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritePlaceModelAdapter extends TypeAdapter<FavoritePlaceModel> {
  @override
  final int typeId = 1;

  @override
  FavoritePlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritePlaceModel(
      name: fields[0] as String,
      address: fields[2] as String?,
      images: (fields[3] as List).cast<String>(),
      townCode: fields[1] as int,
      documentId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritePlaceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.townCode)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.images)
      ..writeByte(4)
      ..write(obj.documentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritePlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePlaceModel _$FavoritePlaceModelFromJson(Map<String, dynamic> json) =>
    FavoritePlaceModel(
      name: json['name'] as String,
      address: json['address'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      townCode: json['townCode'] as int,
    );

Map<String, dynamic> _$FavoritePlaceModelToJson(FavoritePlaceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'townCode': instance.townCode,
      'address': instance.address,
      'images': instance.images,
    };

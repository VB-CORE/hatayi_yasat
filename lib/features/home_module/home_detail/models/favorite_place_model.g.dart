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
      address: fields[4] as String?,
      images: (fields[8] as List).cast<String>(),
      townCode: fields[6] as int,
      description: fields[5] as String?,
      deviceID: fields[3] as String?,
      phone: fields[1] as String,
      owner: fields[2] as String,
      isApproved: fields[7] as bool,
      updatedAt: fields[11] as DateTime?,
      createdAt: fields[10] as DateTime?,
      category: fields[9] as FavoritePlaceCategoryModel?,
      documentId: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritePlaceModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.owner)
      ..writeByte(3)
      ..write(obj.deviceID)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.townCode)
      ..writeByte(7)
      ..write(obj.isApproved)
      ..writeByte(8)
      ..write(obj.images)
      ..writeByte(9)
      ..write(obj.category)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
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
      description: json['description'] as String?,
      deviceID: json['deviceID'] as String?,
      phone: json['phone'] as String,
      owner: json['owner'] as String,
      isApproved: json['isApproved'] as bool,
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : FirebaseTimeParse.datetimeFromTimestamp(
              json['updatedAt'] as Timestamp?),
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : FirebaseTimeParse.datetimeFromTimestamp(
              json['createdAt'] as Timestamp?),
      category: json['category'] == null
          ? null
          : FavoritePlaceCategoryModel.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoritePlaceModelToJson(FavoritePlaceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'owner': instance.owner,
      'deviceID': instance.deviceID,
      'address': instance.address,
      'description': instance.description,
      'townCode': instance.townCode,
      'isApproved': instance.isApproved,
      'images': instance.images,
      'category': instance.category,
      'createdAt': FirebaseTimeParse.dateTimeToTimestamp(instance.createdAt),
      'updatedAt': FirebaseTimeParse.dateTimeToTimestamp(instance.updatedAt),
    };

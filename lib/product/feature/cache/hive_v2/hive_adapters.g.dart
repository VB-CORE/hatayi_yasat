// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class AppCacheModelAdapter extends TypeAdapter<AppCacheModel> {
  @override
  final typeId = 0;

  @override
  AppCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppCacheModel(
      isHomeViewGrid: fields[0] == null ? false : fields[0] as bool,
      lastSearchItems: fields[1] == null
          ? const []
          : (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppCacheModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isHomeViewGrid)
      ..writeByte(1)
      ..write(obj.lastSearchItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreModelCacheAdapter extends TypeAdapter<StoreModelCache> {
  @override
  final typeId = 1;

  @override
  StoreModelCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreModelCache(storeModel: fields[0] as StoreModel);
  }

  @override
  void write(BinaryWriter writer, StoreModelCache obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.storeModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreModelCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MemoryCacheModelAdapter extends TypeAdapter<MemoryCacheModel> {
  @override
  final typeId = 2;

  @override
  MemoryCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoryCacheModel(memoryModel: fields[0] as MemoryModel);
  }

  @override
  void write(BinaryWriter writer, MemoryCacheModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.memoryModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreModelAdapter extends TypeAdapter<StoreModel> {
  @override
  final typeId = 3;

  @override
  StoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreModel(
      name: fields[0] as String,
      owner: fields[1] as String,
      address: fields[3] as String?,
      phone: fields[4] as String,
      images: (fields[5] as List).cast<String>(),
      townCode: (fields[6] as num).toInt(),
      createdAt: fields[16] as DateTime?,
      updatedAt: fields[17] as DateTime?,
      isApproved: fields[10] as bool,
      openTime: fields[8] as String?,
      closeTime: fields[9] as String?,
      ownerId: fields[19] as String?,
      visitCount: fields[7] == null ? 0 : (fields[7] as num).toInt(),
      deviceID: fields[12] as String?,
      description: fields[2] as String?,
      documentId: fields[15] == null ? '' : fields[15] as String,
      category: fields[13] as CategoryModel?,
      latLong: fields[14] as GeoPoint?,
      cityId: fields[11] == null ? '' : fields[11] as String,
      isCommentEnabled: fields[18] == null ? true : fields[18] as bool,
      ratingSum: fields[20] == null ? 0 : (fields[20] as num).toInt(),
      ratingCount: fields[21] == null ? 0 : (fields[21] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, StoreModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.owner)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.townCode)
      ..writeByte(7)
      ..write(obj.visitCount)
      ..writeByte(8)
      ..write(obj.openTime)
      ..writeByte(9)
      ..write(obj.closeTime)
      ..writeByte(10)
      ..write(obj.isApproved)
      ..writeByte(11)
      ..write(obj.cityId)
      ..writeByte(12)
      ..write(obj.deviceID)
      ..writeByte(13)
      ..write(obj.category)
      ..writeByte(14)
      ..write(obj.latLong)
      ..writeByte(15)
      ..write(obj.documentId)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.updatedAt)
      ..writeByte(18)
      ..write(obj.isCommentEnabled)
      ..writeByte(19)
      ..write(obj.ownerId)
      ..writeByte(20)
      ..write(obj.ratingSum)
      ..writeByte(21)
      ..write(obj.ratingCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MemoryModelAdapter extends TypeAdapter<MemoryModel> {
  @override
  final typeId = 4;

  @override
  MemoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoryModel(
      documentId: fields[0] == null ? '' : fields[0] as String,
      title: fields[1] as String?,
      description: fields[2] as String?,
      imageUrls: (fields[3] as List?)?.cast<String>(),
      createdAt: fields[4] as DateTime?,
      updatedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MemoryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.documentId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrls)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GeoPointAdapter extends TypeAdapter<GeoPoint> {
  @override
  final typeId = 5;

  @override
  GeoPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeoPoint(
      (fields[0] as num).toDouble(),
      (fields[1] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, GeoPoint obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final typeId = 6;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      name: fields[0] as String,
      value: (fields[1] as num).toInt(),
      documentId: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.documentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final typeId = 7;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      uid: fields[0] == null ? '' : fields[0] as String,
      email: fields[1] == null ? '' : fields[1] as String,
      displayName: fields[2] == null ? '' : fields[2] as String,
      roleType: fields[3] == null ? 2 : (fields[3] as num).toInt(),
      permissions: fields[4] == null
          ? const []
          : (fields[4] as List).cast<int>(),
      rates: fields[9] == null ? const [] : (fields[9] as List).cast<String>(),
      avatarType: fields[13] == null ? 1 : (fields[13] as num).toInt(),
      fcmToken: fields[7] as String?,
      updatedAt: fields[8] as DateTime?,
      application: fields[11] as UserApplicationModel?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.roleType)
      ..writeByte(4)
      ..write(obj.permissions)
      ..writeByte(7)
      ..write(obj.fcmToken)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.rates)
      ..writeByte(11)
      ..write(obj.application)
      ..writeByte(13)
      ..write(obj.avatarType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserApplicationModelAdapter extends TypeAdapter<UserApplicationModel> {
  @override
  final typeId = 10;

  @override
  UserApplicationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserApplicationModel(
      id: fields[0] == null ? '' : fields[0] as String,
      status: fields[1] == null
          ? UserApplicationStatus.pending
          : fields[1] as UserApplicationStatus,
      deniedMessage: fields[2] as String?,
      ownershipDocumentUrl: fields[3] == null ? '' : fields[3] as String,
      createdAt: fields[4] as DateTime?,
      updatedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserApplicationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.deniedMessage)
      ..writeByte(3)
      ..write(obj.ownershipDocumentUrl)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserApplicationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserApplicationStatusAdapter extends TypeAdapter<UserApplicationStatus> {
  @override
  final typeId = 11;

  @override
  UserApplicationStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserApplicationStatus.pending;
      case 1:
        return UserApplicationStatus.approved;
      case 2:
        return UserApplicationStatus.denied;
      default:
        return UserApplicationStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, UserApplicationStatus obj) {
    switch (obj) {
      case UserApplicationStatus.pending:
        writer.writeByte(0);
      case UserApplicationStatus.approved:
        writer.writeByte(1);
      case UserApplicationStatus.denied:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserApplicationStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

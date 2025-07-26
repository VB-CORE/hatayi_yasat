// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoryModel _$MemoryModelFromJson(Map<String, dynamic> json) => MemoryModel(
      documentId: json['documentId'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: (json['imageUrl'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: FirebaseTimeParse.datetimeFromTimestamp(
          json['createdAt'] as Timestamp?),
      updatedAt: FirebaseTimeParse.datetimeFromTimestamp(
          json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$MemoryModelToJson(MemoryModel instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'createdAt': FirebaseTimeParse.dateTimeToTimestamp(instance.createdAt),
      'updatedAt': FirebaseTimeParse.dateTimeToTimestamp(instance.updatedAt),
    };

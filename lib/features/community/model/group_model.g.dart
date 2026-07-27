// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
  creatorUid: json['creatorUid'] as String? ?? '',
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  imageUrl: json['imageUrl'] as String?,
  categoryValue: (json['categoryValue'] as num?)?.toInt() ?? 0,
  categoryName: json['categoryName'] as String? ?? '',
  isClosed: json['isClosed'] as bool? ?? false,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
  createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
  updatedAt: FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'creatorUid': instance.creatorUid,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': ?instance.imageUrl,
      'categoryValue': instance.categoryValue,
      'categoryName': instance.categoryName,
      'isClosed': instance.isClosed,
      'memberCount': instance.memberCount,
      'createdAt': FirebaseTimeParse.serverTimestampToJson(instance.createdAt),
      'updatedAt': FirebaseTimeParse.serverTimestampToJson(instance.updatedAt),
      'isDeleted': instance.isDeleted,
    };

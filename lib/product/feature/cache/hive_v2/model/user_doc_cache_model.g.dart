// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_doc_cache_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDocCacheModel _$UserDocCacheModelFromJson(Map<String, dynamic> json) =>
    UserDocCacheModel(
      uid: json['uid'] as String,
      roleType: (json['roleType'] as num?)?.toInt() ?? 0,
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserDocCacheModelToJson(UserDocCacheModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'roleType': instance.roleType,
      'permissions': instance.permissions,
    };

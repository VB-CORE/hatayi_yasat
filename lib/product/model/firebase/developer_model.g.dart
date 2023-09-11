// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeveloperModel _$DeveloperModelFromJson(Map<String, dynamic> json) =>
    DeveloperModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String?,
      githubUrl: json['github_url'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$DeveloperModelToJson(DeveloperModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'github_url': instance.githubUrl,
      'image': instance.image,
      'id': instance.id,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupPostModel _$GroupPostModelFromJson(Map<String, dynamic> json) =>
    GroupPostModel(
      author: json['author'] == null
          ? const GroupAuthorModel.empty()
          : GroupAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
      updatedAt: FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
    );

Map<String, dynamic> _$GroupPostModelToJson(GroupPostModel instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'content': instance.content,
      'imageUrl': ?instance.imageUrl,
      'likeCount': instance.likeCount,
      'createdAt': FirebaseTimeParse.serverTimestampToJson(instance.createdAt),
      'updatedAt': FirebaseTimeParse.serverTimestampToJson(instance.updatedAt),
    };

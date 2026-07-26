// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikedPostModel _$LikedPostModelFromJson(Map<String, dynamic> json) =>
    LikedPostModel(
      groupId: json['groupId'] as String? ?? '',
      groupName: json['groupName'] as String? ?? '',
      author: json['author'] == null
          ? const GroupAuthorModel.empty()
          : GroupAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      likedAt: FirebaseTimeParse.datetimeFromTimestamp(json['likedAt']),
    );

Map<String, dynamic> _$LikedPostModelToJson(LikedPostModel instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'author': instance.author.toJson(),
      'content': instance.content,
      'imageUrl': ?instance.imageUrl,
      'likedAt': FirebaseTimeParse.serverTimestampToJson(instance.likedAt),
    };

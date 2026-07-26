// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_discussion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDiscussionModel _$GroupDiscussionModelFromJson(
  Map<String, dynamic> json,
) => GroupDiscussionModel(
  title: json['title'] as String? ?? '',
  author: json['author'] == null
      ? const GroupAuthorModel.empty()
      : GroupAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
  entryCount: (json['entryCount'] as num?)?.toInt() ?? 0,
  createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
  updatedAt: FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
);

Map<String, dynamic> _$GroupDiscussionModelToJson(
  GroupDiscussionModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'author': instance.author.toJson(),
  'entryCount': instance.entryCount,
  'createdAt': FirebaseTimeParse.serverTimestampToJson(instance.createdAt),
  'updatedAt': FirebaseTimeParse.serverTimestampToJson(instance.updatedAt),
};

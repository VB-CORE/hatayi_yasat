// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_discussion_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDiscussionEntryModel _$GroupDiscussionEntryModelFromJson(
  Map<String, dynamic> json,
) => GroupDiscussionEntryModel(
  author: json['author'] == null
      ? const GroupAuthorModel.empty()
      : GroupAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
  content: json['content'] as String? ?? '',
  createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
  updatedAt: FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
);

Map<String, dynamic> _$GroupDiscussionEntryModelToJson(
  GroupDiscussionEntryModel instance,
) => <String, dynamic>{
  'author': instance.author.toJson(),
  'content': instance.content,
  'createdAt': FirebaseTimeParse.serverTimestampToJson(instance.createdAt),
  'updatedAt': FirebaseTimeParse.serverTimestampToJson(instance.updatedAt),
};

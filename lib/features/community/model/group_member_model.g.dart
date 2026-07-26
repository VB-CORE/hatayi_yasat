// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) =>
    GroupMemberModel(
      displayName: json['displayName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      role:
          $enumDecodeNullable(
            _$GroupMemberRoleEnumMap,
            json['role'],
            unknownValue: GroupMemberRole.member,
          ) ??
          GroupMemberRole.member,
      createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
      updatedAt: FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$GroupMemberModelToJson(GroupMemberModel instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'avatarUrl': ?instance.avatarUrl,
      'role': _$GroupMemberRoleEnumMap[instance.role]!,
      'createdAt': FirebaseTimeParse.serverTimestampToJson(instance.createdAt),
      'updatedAt': FirebaseTimeParse.serverTimestampToJson(instance.updatedAt),
      'isDeleted': instance.isDeleted,
    };

const _$GroupMemberRoleEnumMap = {
  GroupMemberRole.member: 'member',
  GroupMemberRole.admin: 'admin',
};

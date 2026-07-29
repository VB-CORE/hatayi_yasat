// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupAuthorModel _$GroupAuthorModelFromJson(Map<String, dynamic> json) =>
    GroupAuthorModel(
      uid: json['uid'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      avatarType: json['avatarType'] as String? ?? 'a1',
      role:
          $enumDecodeNullable(
            _$GroupMemberRoleEnumMap,
            json['role'],
            unknownValue: GroupMemberRole.member,
          ) ??
          GroupMemberRole.member,
    );

Map<String, dynamic> _$GroupAuthorModelToJson(GroupAuthorModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'avatarType': instance.avatarType,
      'role': _$GroupMemberRoleEnumMap[instance.role]!,
    };

const _$GroupMemberRoleEnumMap = {
  GroupMemberRole.member: 'member',
  GroupMemberRole.admin: 'admin',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupAuthorModel _$GroupAuthorModelFromJson(Map<String, dynamic> json) =>
    GroupAuthorModel(
      uid: json['uid'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      avatarType:
          $enumDecodeNullable(_$AvatarTypeEnumMap, json['avatarType']) ??
          AvatarType.a1,
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
      'avatarType': _$AvatarTypeEnumMap[instance.avatarType]!,
      'role': _$GroupMemberRoleEnumMap[instance.role]!,
    };

const _$AvatarTypeEnumMap = {
  AvatarType.a1: 'a1',
  AvatarType.a2: 'a2',
  AvatarType.a3: 'a3',
  AvatarType.a4: 'a4',
  AvatarType.a5: 'a5',
  AvatarType.a6: 'a6',
  AvatarType.a7: 'a7',
};

const _$GroupMemberRoleEnumMap = {
  GroupMemberRole.member: 'member',
  GroupMemberRole.admin: 'admin',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) =>
    GroupMemberModel(
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
      createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
      updatedAt: FirebaseTimeParse.datetimeFromTimestamp(json['updatedAt']),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$GroupMemberModelToJson(GroupMemberModel instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'avatarType': _$AvatarTypeEnumMap[instance.avatarType]!,
      'role': _$GroupMemberRoleEnumMap[instance.role]!,
      'createdAt': FirebaseTimeParse.serverTimestampToJson(instance.createdAt),
      'updatedAt': FirebaseTimeParse.serverTimestampToJson(instance.updatedAt),
      'isDeleted': instance.isDeleted,
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

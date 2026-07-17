// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.user,
  photoUrl: json['photoUrl'] as String?,
  permissions: json['permissions'] == null
      ? const []
      : _permissionsFromJson(json['permissions'] as List?),
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'displayName': instance.displayName,
  'role': _$UserRoleEnumMap[instance.role]!,
  'photoUrl': instance.photoUrl,
  'permissions': _permissionsToJson(instance.permissions),
};

const _$UserRoleEnumMap = {
  UserRole.user: 'user',
  UserRole.merchant: 'merchant',
  UserRole.admin: 'admin',
};

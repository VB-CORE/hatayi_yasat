// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user_doc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUserDocModel _$FirestoreUserDocModelFromJson(
  Map<String, dynamic> json,
) => FirestoreUserDocModel(
  uid: json['uid'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  roleType: json['roleType'] == null
      ? RoleType.user
      : _roleTypeFromJson((json['roleType'] as num?)?.toInt()),
  permissions: json['permissions'] == null
      ? const []
      : _permissionsFromJson(json['permissions'] as List?),
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$FirestoreUserDocModelToJson(
  FirestoreUserDocModel instance,
) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'roleType': _roleTypeToJson(instance.roleType),
  'permissions': _permissionsToJson(instance.permissions),
};

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifeclient/product/model/auth/permission_type.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

part 'firestore_user_doc_model.g.dart';

/// Firestore `users/{uid}` dökümanının kanonik şeması.
@JsonSerializable()
final class FirestoreUserDocModel extends Equatable {
  const FirestoreUserDocModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.roleType = UserRole.user,
    this.permissions = const [],
    this.photoUrl,
  });

  factory FirestoreUserDocModel.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserDocModelFromJson(json);

  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;

  @JsonKey(fromJson: _userRoleFromJson, toJson: _userRoleToJson)
  final UserRole roleType;

  @JsonKey(fromJson: _permissionsFromJson, toJson: _permissionsToJson)
  final List<PermissionType> permissions;

  Map<String, dynamic> toJson() => _$FirestoreUserDocModelToJson(this);

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoUrl,
    roleType,
    permissions,
  ];

  FirestoreUserDocModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    UserRole? roleType,
    List<PermissionType>? permissions,
  }) {
    return FirestoreUserDocModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      roleType: roleType ?? this.roleType,
      permissions: permissions ?? this.permissions,
    );
  }
}

UserRole _userRoleFromJson(int? code) =>
    UserRole.fromCode(code) ?? UserRole.user;

int _userRoleToJson(UserRole role) => role.code;

List<PermissionType> _permissionsFromJson(List<dynamic>? json) =>
    PermissionType.parseList(json);

List<int> _permissionsToJson(List<PermissionType> permissions) =>
    permissions.map((permission) => permission.code).toList();

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/auth/permission_type.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

part 'app_user_model.g.dart';

@JsonSerializable()
final class AppUser extends BaseFirebaseModel<AppUser>
    with EquatableMixin
    implements BaseFirebaseConvert<AppUser> {
  const AppUser({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.photoUrl,
    this.roleType = UserRole.user,
    this.permissions = const [],
  });

  const AppUser.empty() : this();

  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;

  @JsonKey(fromJson: _userRoleFromJson, toJson: _userRoleToJson)
  final UserRole roleType;

  @JsonKey(fromJson: _permissionsFromJson, toJson: _permissionsToJson)
  final List<PermissionType> permissions;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get documentId => uid;

  @override
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  AppUser fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  @override
  AppUser fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data();
    if (data == null) return this;
    return _$AppUserFromJson(data);
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoUrl,
    roleType,
    permissions,
  ];

  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    UserRole? roleType,
    List<PermissionType>? permissions,
  }) {
    return AppUser(
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

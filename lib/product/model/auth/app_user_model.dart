import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifeclient/product/model/auth/permission_type.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

part 'app_user_model.g.dart';

@JsonSerializable()
final class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    this.role = UserRole.user,
    this.photoUrl,
    this.permissions = const [],
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.fromFirebaseUser(User user, Map<String, dynamic>? docData) {
    return AppUser.fromJson({
      'uid': user.uid,
      'email': user.email ?? '',
      'displayName': user.displayName ?? user.email ?? '',
      'photoUrl': user.photoURL,
      'permissions': docData?['permissions'],
    });
  }

  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final String? photoUrl;

  @JsonKey(fromJson: _permissionsFromJson, toJson: _permissionsToJson)
  final List<PermissionType> permissions;

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    role,
    photoUrl,
    permissions,
  ];

  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    UserRole? role,
    String? photoUrl,
    List<PermissionType>? permissions,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      permissions: permissions ?? this.permissions,
    );
  }
}

List<PermissionType> _permissionsFromJson(List<dynamic>? json) =>
    PermissionType.parseList(json);

List<int> _permissionsToJson(List<PermissionType> permissions) =>
    permissions.map((permission) => permission.code).toList();

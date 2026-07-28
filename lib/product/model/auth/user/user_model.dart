import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/model/auth/app_permission.dart';
import 'package:lifeclient/product/model/auth/user/avatar_type.dart';
import 'package:lifeclient/product/model/auth/user/user_application_model.dart';
import 'package:lifeclient/product/model/auth/user/user_role.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class UserModel extends BaseFirebaseModel<UserModel>
    with Equatable, CacheModel {
  const UserModel({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.roleType = 2,
    this.permissions = const [],
    this.rates = const [],
    this.avatarType = AvatarType.a1,
    this.fcmToken,
    this.updatedAt,
    this.application,
  });

  const UserModel.empty() : this();

  factory UserModel.fromFirebaseUser(User user) => UserModel(
    uid: user.uid,
    email: user.email ?? '',
    displayName: user.displayName ?? user.email ?? '',
    avatarType: AvatarType.values[Random().nextInt(AvatarType.values.length)],
  );

  final String uid;
  final String email;
  final String displayName;
  final int roleType;
  final List<int> permissions;
  final List<String> rates;
  final AvatarType avatarType;
  final String? fcmToken;
  @JsonKey(
    includeToJson: false,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;
  final UserApplicationModel? application;

  UserRole get role => UserRole.fromRoleType(roleType);

  bool get isAdmin => role == UserRole.admin;

  bool get canCreateGroup =>
      permissions.contains(AppPermission.createGroup.value);

  bool get canCreateTopic =>
      permissions.contains(AppPermission.createTopic.value);

  @override
  String get documentId => uid;

  @override
  String get id => uid;

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static Map<String, Object?> updateFields({
    String? displayName,
    AvatarType? avatarType,
    FieldValue? rates,
    UserApplicationModel? application,
  }) {
    return {
      'displayName': ?displayName,
      'avatarType': ?avatarType?.name,
      'rates': ?rates,
      'application': ?application?.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  UserModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const UserModel.empty();
    return fromJson(data).copyWith(uid: snapshot.id);
  }

  @override
  UserModel fromDynamicJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw Exception('Invalid json type');
    return fromJson(json);
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    int? roleType,
    List<int>? permissions,
    List<String>? rates,
    AvatarType? avatarType,
    String? fcmToken,
    DateTime? updatedAt,
    UserApplicationModel? application,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      roleType: roleType ?? this.roleType,
      permissions: permissions ?? this.permissions,
      rates: rates ?? this.rates,
      avatarType: avatarType ?? this.avatarType,
      fcmToken: fcmToken ?? this.fcmToken,
      updatedAt: updatedAt ?? this.updatedAt,
      application: application ?? this.application,
    );
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    roleType,
    permissions,
    rates,
    avatarType,
    fcmToken,
    updatedAt,
    application,
  ];
}

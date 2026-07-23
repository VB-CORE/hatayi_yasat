import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/model/auth/app_permission.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class UserModel extends BaseFirebaseModel<UserModel>
    with EquatableMixin, CacheModel {
  const UserModel({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.roleType = 2,
    this.permissions = const [],
    this.photoUrl,
    this.merchantStoreId,
    this.fcmToken,
    this.updatedAt,
  });

  const UserModel.empty() : this();

  factory UserModel.fromFirebaseUser(User user) => UserModel(
    uid: user.uid,
    email: user.email ?? '',
    displayName: user.displayName ?? user.email ?? '',
    photoUrl: user.photoURL,
  );

  @JsonKey(defaultValue: '')
  final String uid;
  @JsonKey(defaultValue: '')
  final String email;
  @JsonKey(defaultValue: '')
  final String displayName;
  @JsonKey(defaultValue: 2)
  final int roleType;
  @JsonKey(defaultValue: <int>[])
  final List<int> permissions;
  final String? photoUrl;
  final String? merchantStoreId;
  final String? fcmToken;
  @JsonKey(
    includeToJson: false,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;

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
    String? photoUrl,
    String? merchantStoreId,
    String? fcmToken,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      roleType: roleType ?? this.roleType,
      permissions: permissions ?? this.permissions,
      photoUrl: photoUrl ?? this.photoUrl,
      merchantStoreId: merchantStoreId ?? this.merchantStoreId,
      fcmToken: fcmToken ?? this.fcmToken,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    roleType,
    permissions,
    photoUrl,
    merchantStoreId,
    fcmToken,
    updatedAt,
  ];
}

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
    with Equatable, CacheModel {
  const UserModel({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.roleType = 2,
    this.permissions = const [],
    this.rates = const [],
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

  final String uid;
  final String email;
  final String displayName;
  final int roleType;
  final List<int> permissions;
  final List<String> rates;
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

  static Map<String, Object?> updateFields({
    String? displayName,
    String? photoUrl,
    FieldValue? rates,
  }) {
    return {
      'displayName': ?displayName,
      'photoUrl': ?photoUrl,
      'rates': ?rates,
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
      rates: rates ?? this.rates,
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
    rates,
    photoUrl,
    merchantStoreId,
    fcmToken,
    updatedAt,
  ];
}

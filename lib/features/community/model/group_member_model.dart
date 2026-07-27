import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';
import 'package:lifeclient/product/model/auth/user/user_model.dart';

part 'group_member_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupMemberModel extends BaseFirebaseModel<GroupMemberModel>
    with EquatableMixin {
  const GroupMemberModel({
    this.id = '',
    this.displayName = '',
    this.avatarUrl,
    this.role = GroupMemberRole.member,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  const GroupMemberModel.empty() : this();

  factory GroupMemberModel.fromUser(
    UserModel user, {
    GroupMemberRole role = GroupMemberRole.member,
  }) {
    return GroupMemberModel(
      id: user.uid,
      displayName: user.displayName,
      avatarUrl: user.photoUrl,
      role: role,
    );
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  final String displayName;
  final String? avatarUrl;
  @JsonKey(unknownEnumValue: GroupMemberRole.member)
  final GroupMemberRole role;

  @JsonKey(
    toJson: FirebaseTimeParse.serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: FirebaseTimeParse.serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;

  final bool isDeleted;

  bool get isAdmin => role == GroupMemberRole.admin;

  @override
  String get documentId => id;

  @override
  Map<String, dynamic> toJson() => _$GroupMemberModelToJson(this);

  @override
  GroupMemberModel fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);

  @override
  GroupMemberModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) return const GroupMemberModel.empty();
    return fromJson(data).copyWith(id: snapshot.id);
  }

  @override
  List<Object?> get props => [
    id,
    displayName,
    avatarUrl,
    role,
    createdAt,
    updatedAt,
    isDeleted,
  ];

  GroupMemberModel copyWith({
    String? id,
    String? displayName,
    String? avatarUrl,
    GroupMemberRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return GroupMemberModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

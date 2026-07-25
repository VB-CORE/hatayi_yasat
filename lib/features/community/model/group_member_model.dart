import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/community_timestamp.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';
import 'package:lifeclient/product/utility/constants/regex_types.dart';

part 'group_member_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupMemberModel extends BaseFirebaseModel<GroupMemberModel>
    with EquatableMixin {
  const GroupMemberModel({
    this.id = '',
    this.displayName = '',
    this.username = '',
    this.avatarUrl,
    this.role = GroupMemberRole.member,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  const GroupMemberModel.empty() : this();

  factory GroupMemberModel.fromUser(UserModel user) {
    return GroupMemberModel(
      id: user.uid,
      displayName: user.displayName,
      username: user.email.split('@').firstOrNull ?? '-',
      avatarUrl: user.photoUrl,
    );
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  final String displayName;
  final String username;
  final String? avatarUrl;
  @JsonKey(unknownEnumValue: GroupMemberRole.member)
  final GroupMemberRole role;

  @JsonKey(
    toJson: serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? createdAt;

  @JsonKey(
    toJson: serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? updatedAt;

  final bool isDeleted;

  String get maskedDisplayName {
    return displayName
        .trim()
        .split(RegexTypes.whitespace)
        .where((word) => word.isNotEmpty)
        .map(
          (word) =>
              word.length <= 1 ? word : '${word[0]}${'•' * (word.length - 1)}',
        )
        .join(' ');
  }

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
    username,
    avatarUrl,
    role,
    createdAt,
    updatedAt,
    isDeleted,
  ];

  GroupMemberModel copyWith({
    String? id,
    String? displayName,
    String? username,
    String? avatarUrl,
    GroupMemberRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return GroupMemberModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

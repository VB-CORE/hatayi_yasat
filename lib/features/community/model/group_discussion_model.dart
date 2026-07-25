import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/community_timestamp.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';

part 'group_discussion_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupDiscussionModel extends BaseFirebaseModel<GroupDiscussionModel>
    with EquatableMixin {
  const GroupDiscussionModel({
    this.id = '',
    this.title = '',
    this.authorUid = '',
    this.authorDisplayName = '',
    this.authorUsername = '',
    this.authorAvatarUrl,
    this.authorRole = GroupMemberRole.member,
    this.createdAt,
    this.updatedAt,
    this.entryCount = 0,
    this.isDeleted = false,
  });

  const GroupDiscussionModel.empty() : this();

  factory GroupDiscussionModel.fromAuthor({
    required GroupMemberModel author,
    required String title,
  }) => GroupDiscussionModel(
    title: title,
    authorUid: author.id,
    authorDisplayName: author.displayName,
    authorUsername: author.username,
    authorAvatarUrl: author.avatarUrl,
    authorRole: author.role,
  );

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  final String title;

  final String authorUid;
  final String authorDisplayName;
  final String authorUsername;
  final String? authorAvatarUrl;
  @JsonKey(unknownEnumValue: GroupMemberRole.member)
  final GroupMemberRole authorRole;

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

  @JsonKey(includeToJson: false)
  final int entryCount;

  final bool isDeleted;

  GroupMemberModel get author => GroupMemberModel(
    id: authorUid,
    displayName: authorDisplayName,
    username: authorUsername,
    avatarUrl: authorAvatarUrl,
    role: authorRole,
  );

  @override
  String get documentId => id;

  @override
  Map<String, dynamic> toJson() => _$GroupDiscussionModelToJson(this);

  @override
  GroupDiscussionModel fromJson(Map<String, dynamic> json) =>
      _$GroupDiscussionModelFromJson(json);

  @override
  GroupDiscussionModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) return const GroupDiscussionModel.empty();
    return fromJson(data).copyWith(id: snapshot.id);
  }

  @override
  List<Object?> get props => [
    id,
    title,
    authorUid,
    authorDisplayName,
    authorUsername,
    authorAvatarUrl,
    authorRole,
    createdAt,
    updatedAt,
    entryCount,
    isDeleted,
  ];

  GroupDiscussionModel copyWith({
    String? id,
    String? title,
    String? authorUid,
    String? authorDisplayName,
    String? authorUsername,
    String? authorAvatarUrl,
    GroupMemberRole? authorRole,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? entryCount,
    bool? isDeleted,
  }) {
    return GroupDiscussionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      authorUid: authorUid ?? this.authorUid,
      authorDisplayName: authorDisplayName ?? this.authorDisplayName,
      authorUsername: authorUsername ?? this.authorUsername,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      authorRole: authorRole ?? this.authorRole,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      entryCount: entryCount ?? this.entryCount,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/community_timestamp.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';

part 'group_discussion_entry_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupDiscussionEntryModel
    extends BaseFirebaseModel<GroupDiscussionEntryModel>
    with EquatableMixin {
  const GroupDiscussionEntryModel({
    this.id = '',
    this.authorUid = '',
    this.authorDisplayName = '',
    this.authorUsername = '',
    this.authorAvatarUrl,
    this.authorRole = GroupMemberRole.member,
    this.content = '',
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  const GroupDiscussionEntryModel.empty() : this();

  factory GroupDiscussionEntryModel.fromAuthor({
    required GroupMemberModel author,
    required String content,
  }) => GroupDiscussionEntryModel(
    authorUid: author.id,
    authorDisplayName: author.displayName,
    authorUsername: author.username,
    authorAvatarUrl: author.avatarUrl,
    authorRole: author.role,
    content: content,
  );

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;

  final String authorUid;
  final String authorDisplayName;
  final String authorUsername;
  final String? authorAvatarUrl;
  @JsonKey(unknownEnumValue: GroupMemberRole.member)
  final GroupMemberRole authorRole;

  final String content;

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
  Map<String, dynamic> toJson() => _$GroupDiscussionEntryModelToJson(this);

  @override
  GroupDiscussionEntryModel fromJson(Map<String, dynamic> json) =>
      _$GroupDiscussionEntryModelFromJson(json);

  @override
  GroupDiscussionEntryModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) return const GroupDiscussionEntryModel.empty();
    return fromJson(data).copyWith(id: snapshot.id);
  }

  @override
  List<Object?> get props => [
    id,
    authorUid,
    authorDisplayName,
    authorUsername,
    authorAvatarUrl,
    authorRole,
    content,
    createdAt,
    updatedAt,
    isDeleted,
  ];

  GroupDiscussionEntryModel copyWith({
    String? id,
    String? authorUid,
    String? authorDisplayName,
    String? authorUsername,
    String? authorAvatarUrl,
    GroupMemberRole? authorRole,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return GroupDiscussionEntryModel(
      id: id ?? this.id,
      authorUid: authorUid ?? this.authorUid,
      authorDisplayName: authorDisplayName ?? this.authorDisplayName,
      authorUsername: authorUsername ?? this.authorUsername,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      authorRole: authorRole ?? this.authorRole,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

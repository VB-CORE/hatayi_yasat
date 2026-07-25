import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/community_timestamp.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';

part 'group_post_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupPostModel extends BaseFirebaseModel<GroupPostModel>
    with EquatableMixin {
  const GroupPostModel({
    this.id = '',
    this.authorUid = '',
    this.authorDisplayName = '',
    this.authorUsername = '',
    this.authorAvatarUrl,
    this.authorRole = GroupMemberRole.member,
    this.content = '',
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.imageFile,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isDeleted = false,
  });

  const GroupPostModel.empty() : this();

  factory GroupPostModel.fromAuthor({
    required GroupMemberModel author,
    required String content,
    String? imageUrl,
    File? imageFile,
  }) => GroupPostModel(
    authorUid: author.id,
    authorDisplayName: author.displayName,
    authorUsername: author.username,
    authorAvatarUrl: author.avatarUrl,
    authorRole: author.role,
    content: content,
    imageUrl: imageUrl,
    imageFile: imageFile,
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

  final String? imageUrl;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? imageFile;

  final int likeCount;
  final int commentCount;

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
  Map<String, dynamic> toJson() => _$GroupPostModelToJson(this);

  @override
  GroupPostModel fromJson(Map<String, dynamic> json) =>
      _$GroupPostModelFromJson(json);

  @override
  GroupPostModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const GroupPostModel.empty();
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
    imageUrl,
    imageFile,
    likeCount,
    commentCount,
    isDeleted,
  ];

  GroupPostModel copyWith({
    String? id,
    String? authorUid,
    String? authorDisplayName,
    String? authorUsername,
    String? authorAvatarUrl,
    GroupMemberRole? authorRole,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    File? imageFile,
    int? likeCount,
    int? commentCount,
    bool? isDeleted,
  }) {
    return GroupPostModel(
      id: id ?? this.id,
      authorUid: authorUid ?? this.authorUid,
      authorDisplayName: authorDisplayName ?? this.authorDisplayName,
      authorUsername: authorUsername ?? this.authorUsername,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      authorRole: authorRole ?? this.authorRole,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

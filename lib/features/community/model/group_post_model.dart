import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

final class GroupPostModel extends BaseFirebaseModel<GroupPostModel>
    with EquatableMixin {
  const GroupPostModel({
    this.id = '',
    this.author = const GroupMemberModel.empty(),
    this.content = '',
    this.createdAt,
    this.imageUrl,
    this.imageFile,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isDeleted = false,
  });

  const GroupPostModel.empty() : this();

  final String id;
  final GroupMemberModel author;
  final String content;
  final DateTime? createdAt;
  final String? imageUrl;

  final File? imageFile;
  final int likeCount;
  final int commentCount;
  final bool isDeleted;

  @override
  String get documentId => id;

  @override
  Map<String, dynamic> toJson() => {
    ...author.toAuthorJson(),
    'content': content,
    if (imageUrl != null) 'imageUrl': imageUrl,
    'likeCount': likeCount,
    'commentCount': commentCount,
    'isDeleted': isDeleted,
    'createdAt': FieldValue.serverTimestamp(),
  };

  @override
  GroupPostModel fromJson(Map<String, dynamic> json) => GroupPostModel(
    author: GroupMemberModel.authorFromJson(json),
    content: (json['content'] as String?) ?? '',
    imageUrl: json['imageUrl'] as String?,
    createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
    likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
    commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
    isDeleted: (json['isDeleted'] as bool?) ?? false,
  );

  @override
  GroupPostModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const GroupPostModel.empty();
    return fromJson(data).copyWith(id: snapshot.id);
  }

  @override
  List<Object?> get props => [
    id,
    author,
    content,
    createdAt,
    imageUrl,
    imageFile,
    likeCount,
    commentCount,
    isDeleted,
  ];

  GroupPostModel copyWith({
    String? id,
    GroupMemberModel? author,
    String? content,
    DateTime? createdAt,
    String? imageUrl,
    File? imageFile,
    int? likeCount,
    int? commentCount,
    bool? isDeleted,
  }) {
    return GroupPostModel(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

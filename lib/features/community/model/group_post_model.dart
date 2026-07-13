import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

final class GroupPostModel extends Equatable {
  const GroupPostModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    this.imageUrl,
    this.imageFile,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLikedByCurrentUser = false,
  });

  final String id;
  final GroupMemberModel author;
  final String content;
  final DateTime createdAt;
  final String? imageUrl;

  final File? imageFile;
  final int likeCount;
  final int commentCount;
  final bool isLikedByCurrentUser;

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
    isLikedByCurrentUser,
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
    bool? isLikedByCurrentUser,
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
      isLikedByCurrentUser: isLikedByCurrentUser ?? this.isLikedByCurrentUser,
    );
  }
}

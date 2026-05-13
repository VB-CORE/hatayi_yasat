import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Comment under a post. Stored at `comments/{id}` keyed by parent post.
final class CommentModel extends Equatable {
  const CommentModel({
    required this.id,
    required this.postId,
    required this.authorUid,
    required this.authorName,
    required this.text,
    required this.createdAt,
    required this.likeCount,
  });

  factory CommentModel.fromJson(String id, Map<String, dynamic> json) {
    return CommentModel(
      id: id,
      postId: json['postId'] as String? ?? '',
      authorUid: json['authorUid'] as String? ?? 'guest',
      authorName: json['authorName'] as String? ?? '',
      text: json['text'] as String? ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String postId;
  final String authorUid;
  final String authorName;
  final String text;
  final DateTime createdAt;
  final int likeCount;

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'authorUid': authorUid,
    'authorName': authorName,
    'text': text,
    'createdAt': Timestamp.fromDate(createdAt),
    'likeCount': likeCount,
  };

  @override
  List<Object?> get props => [id, postId, authorUid, text, createdAt];
}

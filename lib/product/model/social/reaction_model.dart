import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// User reaction to a post. V2 only models a binary "like" (heart) for now;
/// the kind enum exists so future emoji reactions can be added without a
/// schema break. Stored at `post_likes/{postId}_{uid}` as a presence doc.
final class ReactionModel extends Equatable {
  const ReactionModel({
    required this.id,
    required this.postId,
    required this.uid,
    required this.kind,
    required this.createdAt,
  });

  factory ReactionModel.fromJson(String id, Map<String, dynamic> json) {
    return ReactionModel(
      id: id,
      postId: json['postId'] as String? ?? '',
      uid: json['uid'] as String? ?? 'guest',
      kind: ReactionKind.fromString(json['kind'] as String?),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  final String id;
  final String postId;
  final String uid;
  final ReactionKind kind;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'uid': uid,
    'kind': kind.name,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  @override
  List<Object?> get props => [id, postId, uid, kind];
}

enum ReactionKind {
  like
  ;

  static ReactionKind fromString(String? value) => ReactionKind.like;
}

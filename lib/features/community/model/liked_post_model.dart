import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_author_model.dart';
import 'package:lifeclient/features/community/model/group_post_model.dart';

part 'liked_post_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class LikedPostModel extends BaseFirebaseModel<LikedPostModel>
    with EquatableMixin {
  const LikedPostModel({
    this.postId = '',
    this.groupId = '',
    this.groupName = '',
    this.author = const GroupAuthorModel.empty(),
    this.content = '',
    this.imageUrl,
    this.likedAt,
  });

  const LikedPostModel.empty() : this();

  factory LikedPostModel.fromPost({
    required GroupPostModel post,
    required String groupId,
    required String groupName,
  }) {
    return LikedPostModel(
      postId: post.id,
      groupId: groupId,
      groupName: groupName,
      author: post.author,
      content: post.content,
      imageUrl: post.imageUrl,
    );
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String postId;

  final String groupId;
  final String groupName;
  final GroupAuthorModel author;
  final String content;
  final String? imageUrl;

  @JsonKey(
    toJson: FirebaseTimeParse.serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? likedAt;

  @override
  String get documentId => postId;

  @override
  Map<String, dynamic> toJson() => _$LikedPostModelToJson(this);

  @override
  LikedPostModel fromJson(Map<String, dynamic> json) =>
      _$LikedPostModelFromJson(json);

  @override
  LikedPostModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const LikedPostModel.empty();
    return fromJson(data).copyWith(postId: snapshot.id);
  }

  @override
  List<Object?> get props => [
    postId,
    groupId,
    groupName,
    author,
    content,
    imageUrl,
    likedAt,
  ];

  LikedPostModel copyWith({
    String? postId,
    String? groupId,
    String? groupName,
    GroupAuthorModel? author,
    String? content,
    String? imageUrl,
    DateTime? likedAt,
  }) {
    return LikedPostModel(
      postId: postId ?? this.postId,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      author: author ?? this.author,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      likedAt: likedAt ?? this.likedAt,
    );
  }
}

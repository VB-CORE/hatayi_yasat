import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_author_model.dart';

part 'group_discussion_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupDiscussionModel extends BaseFirebaseModel<GroupDiscussionModel>
    with EquatableMixin {
  const GroupDiscussionModel({
    this.id = '',
    this.title = '',
    this.author = const GroupAuthorModel.empty(),
    this.entryCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  const GroupDiscussionModel.empty() : this();

  factory GroupDiscussionModel.opening({
    required GroupAuthorModel author,
    required String title,
  }) {
    return GroupDiscussionModel(title: title, author: author, entryCount: 1);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;

  final String title;
  final GroupAuthorModel author;
  final int entryCount;

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
    author,
    entryCount,
    createdAt,
    updatedAt,
  ];

  GroupDiscussionModel copyWith({
    String? id,
    String? title,
    GroupAuthorModel? author,
    int? entryCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupDiscussionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      entryCount: entryCount ?? this.entryCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_author_model.dart';

part 'group_discussion_entry_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupDiscussionEntryModel
    extends BaseFirebaseModel<GroupDiscussionEntryModel>
    with EquatableMixin {
  const GroupDiscussionEntryModel({
    this.id = '',
    this.author = const GroupAuthorModel.empty(),
    this.content = '',
    this.createdAt,
    this.updatedAt,
  });

  const GroupDiscussionEntryModel.empty() : this();

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;

  final GroupAuthorModel author;
  final String content;

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
    author,
    content,
    createdAt,
    updatedAt,
  ];

  GroupDiscussionEntryModel copyWith({
    String? id,
    GroupAuthorModel? author,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupDiscussionEntryModel(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

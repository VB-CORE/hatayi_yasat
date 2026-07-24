import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

final class GroupDiscussionEntryModel
    extends BaseFirebaseModel<GroupDiscussionEntryModel>
    with EquatableMixin {
  const GroupDiscussionEntryModel({
    this.id = '',
    this.author = const GroupMemberModel.empty(),
    this.content = '',
    this.createdAt,
    this.isDeleted = false,
  });

  const GroupDiscussionEntryModel.empty() : this();

  final String id;
  final GroupMemberModel author;
  final String content;
  final DateTime? createdAt;
  final bool isDeleted;

  @override
  String get documentId => id;

  @override
  Map<String, dynamic> toJson() => {
    ...author.toAuthorJson(),
    'content': content,
    'isDeleted': isDeleted,
    'createdAt': FieldValue.serverTimestamp(),
  };

  @override
  GroupDiscussionEntryModel fromJson(Map<String, dynamic> json) =>
      GroupDiscussionEntryModel(
        author: GroupMemberModel.authorFromJson(json),
        content: (json['content'] as String?) ?? '',
        createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
        isDeleted: (json['isDeleted'] as bool?) ?? false,
      );

  @override
  GroupDiscussionEntryModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) return const GroupDiscussionEntryModel.empty();
    return fromJson(data).copyWith(id: snapshot.id);
  }

  @override
  List<Object?> get props => [id, author, content, createdAt, isDeleted];

  GroupDiscussionEntryModel copyWith({
    String? id,
    GroupMemberModel? author,
    String? content,
    DateTime? createdAt,
    bool? isDeleted,
  }) {
    return GroupDiscussionEntryModel(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

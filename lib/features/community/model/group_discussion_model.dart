import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

final class GroupDiscussionModel extends BaseFirebaseModel<GroupDiscussionModel>
    with EquatableMixin {
  const GroupDiscussionModel({
    this.id = '',
    this.title = '',
    this.author = const GroupMemberModel.empty(),
    this.createdAt,
    this.isDeleted = false,
    this.entryCount = 0,
  });

  const GroupDiscussionModel.empty() : this();

  final String id;
  final String title;
  final GroupMemberModel author;
  final DateTime? createdAt;
  final bool isDeleted;

  /// Alt koleksiyondan (entries) sayılıp doldurulur; dokümanda saklanmaz.
  final int entryCount;

  @override
  String get documentId => id;

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    ...author.toAuthorJson(),
    'isDeleted': isDeleted,
    'createdAt': FieldValue.serverTimestamp(),
  };

  @override
  GroupDiscussionModel fromJson(Map<String, dynamic> json) =>
      GroupDiscussionModel(
        title: (json['title'] as String?) ?? '',
        author: GroupMemberModel.authorFromJson(json),
        createdAt: FirebaseTimeParse.datetimeFromTimestamp(json['createdAt']),
        isDeleted: (json['isDeleted'] as bool?) ?? false,
      );

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
    createdAt,
    isDeleted,
    entryCount,
  ];

  GroupDiscussionModel copyWith({
    String? id,
    String? title,
    GroupMemberModel? author,
    DateTime? createdAt,
    bool? isDeleted,
    int? entryCount,
  }) {
    return GroupDiscussionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
      entryCount: entryCount ?? this.entryCount,
    );
  }
}

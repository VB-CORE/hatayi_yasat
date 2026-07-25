import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
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
    this.entries = const [],
  });

  const GroupDiscussionModel.empty() : this();

  final String id;
  final String title;
  final GroupMemberModel author;
  final DateTime? createdAt;
  final bool isDeleted;

  final int entryCount;

  // Geçici geriye-uyumluluk: eski UI discussion.entries okuyor. UI Firestore'a
  // taşınınca (entryCount + entries alt-koleksiyonu) bu alan kaldırılacak.
  final List<GroupDiscussionEntryModel> entries;

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
    entries,
  ];

  GroupDiscussionModel copyWith({
    String? id,
    String? title,
    GroupMemberModel? author,
    DateTime? createdAt,
    bool? isDeleted,
    int? entryCount,
    List<GroupDiscussionEntryModel>? entries,
  }) {
    return GroupDiscussionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
      entryCount: entryCount ?? this.entryCount,
      entries: entries ?? this.entries,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';

final class GroupDiscussionModel extends Equatable {
  const GroupDiscussionModel({
    required this.id,
    required this.title,
    required this.author,
    required this.createdAt,
    this.entries = const [],
  });

  final String id;
  final String title;
  final GroupMemberModel author;
  final DateTime createdAt;

  /// Mock aşamasında tartışmanın gönderileri — Firestore'a geçince
  /// `DiscussionDetailViewModel` kendi sorgusunu yapacak, bu alan kalkacak.
  final List<GroupDiscussionEntryModel> entries;

  int get entryCount => entries.length;

  @override
  List<Object> get props => [id, title, author, createdAt, entries];

  GroupDiscussionModel copyWith({
    String? id,
    String? title,
    GroupMemberModel? author,
    DateTime? createdAt,
    List<GroupDiscussionEntryModel>? entries,
  }) {
    return GroupDiscussionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      entries: entries ?? this.entries,
    );
  }
}

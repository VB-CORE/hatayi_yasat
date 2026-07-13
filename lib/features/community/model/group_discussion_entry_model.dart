import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

final class GroupDiscussionEntryModel extends Equatable {
  const GroupDiscussionEntryModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
  });

  final String id;
  final GroupMemberModel author;
  final String content;
  final DateTime createdAt;

  @override
  List<Object> get props => [id, author, content, createdAt];
}

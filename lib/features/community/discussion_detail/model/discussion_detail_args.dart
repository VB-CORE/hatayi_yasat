import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/model/group_model.dart';

final class DiscussionDetailArgs extends Equatable {
  const DiscussionDetailArgs({required this.group, required this.discussion});

  final GroupModel group;
  final GroupDiscussionModel discussion;

  @override
  List<Object> get props => [group, discussion];
}

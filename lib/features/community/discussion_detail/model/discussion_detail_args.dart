import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class DiscussionDetailArgs extends Equatable {
  const DiscussionDetailArgs({required this.group, required this.discussion});

  final GroupModel group;
  final GroupDiscussionModel discussion;

  @override
  List<Object> get props => [group, discussion];
}

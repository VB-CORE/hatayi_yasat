import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';

@immutable
final class GroupDiscussionsState extends Equatable {
  const GroupDiscussionsState({
    required this.discussions,
    this.isFetching = false,
    this.isError = false,
  });

  final List<GroupDiscussionModel> discussions;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [discussions, isFetching, isError];

  GroupDiscussionsState copyWith({
    List<GroupDiscussionModel>? discussions,
    bool? isFetching,
    bool? isError,
  }) {
    return GroupDiscussionsState(
      discussions: discussions ?? this.discussions,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}

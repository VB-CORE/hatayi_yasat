import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

@immutable
final class DiscussionDetailState extends Equatable {
  const DiscussionDetailState({
    required this.entries,
    required this.currentMember,
    this.isFetching = false,
    this.isError = false,
  });

  final List<GroupDiscussionEntryModel> entries;
  final GroupMemberModel currentMember;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [entries, currentMember, isFetching, isError];

  DiscussionDetailState copyWith({
    List<GroupDiscussionEntryModel>? entries,
    GroupMemberModel? currentMember,
    bool? isFetching,
    bool? isError,
  }) {
    return DiscussionDetailState(
      entries: entries ?? this.entries,
      currentMember: currentMember ?? this.currentMember,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}

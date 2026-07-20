import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/community/model/group_model.dart';

@immutable
final class GroupsState extends Equatable {
  const GroupsState({
    required this.groups,
    this.isFetching = false,
    this.isError = false,
  });

  final List<GroupModel> groups;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [
    groups,
    isFetching,
    isError,
  ];

  GroupsState copyWith({
    List<GroupModel>? groups,
    bool? isFetching,
    bool? isError,
  }) {
    return GroupsState(
      groups: groups ?? this.groups,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}

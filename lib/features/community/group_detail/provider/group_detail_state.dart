import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class GroupDetailState extends Equatable {
  const GroupDetailState({this.group, this.isError = false});

  final GroupModel? group;
  final bool isError;

  @override
  List<Object?> get props => [group, isError];

  GroupDetailState copyWith({GroupModel? group, bool? isError}) {
    return GroupDetailState(
      group: group ?? this.group,
      isError: isError ?? this.isError,
    );
  }
}

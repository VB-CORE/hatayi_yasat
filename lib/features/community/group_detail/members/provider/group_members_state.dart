import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

@immutable
final class GroupMembersState extends Equatable {
  const GroupMembersState({
    this.currentMember,
    this.isFetching = false,
    this.isProcessing = false,
    this.isError = false,
  });

  final GroupMemberModel? currentMember;
  final bool isFetching;
  final bool isProcessing;
  final bool isError;

  bool get isMember => currentMember != null;

  bool get isAdmin => currentMember?.isAdmin ?? false;

  GroupMembersState copyWith({
    GroupMemberModel? currentMember,
    bool clearCurrentMember = false,
    bool? isFetching,
    bool? isProcessing,
    bool? isError,
  }) {
    return GroupMembersState(
      currentMember: clearCurrentMember
          ? null
          : currentMember ?? this.currentMember,
      isFetching: isFetching ?? this.isFetching,
      isProcessing: isProcessing ?? this.isProcessing,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [currentMember, isFetching, isProcessing, isError];
}

import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';

final class GroupMembersState extends Equatable {
  const GroupMembersState({
    this.members = const [],
    this.isMember = false,
    this.isFetching = false,
    this.isProcessing = false,
    this.isError = false,
  });

  final List<GroupMemberModel> members;
  final bool isMember;
  final bool isFetching;
  final bool isProcessing;
  final bool isError;

  int get memberCount => members.length;

  @override
  List<Object?> get props => [
    members,
    isMember,
    isFetching,
    isProcessing,
    isError,
  ];

  GroupMembersState copyWith({
    List<GroupMemberModel>? members,
    bool? isMember,
    bool? isFetching,
    bool? isProcessing,
    bool? isError,
  }) {
    return GroupMembersState(
      members: members ?? this.members,
      isMember: isMember ?? this.isMember,
      isFetching: isFetching ?? this.isFetching,
      isProcessing: isProcessing ?? this.isProcessing,
      isError: isError ?? this.isError,
    );
  }
}

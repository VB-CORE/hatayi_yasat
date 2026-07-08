import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';

final class GroupMemberModel extends Equatable {
  const GroupMemberModel({
    required this.id,
    required this.displayName,
    required this.username,
    this.avatarUrl,
    this.role = GroupMemberRole.member,
  });

  final String id;
  final String displayName;
  final String username;
  final String? avatarUrl;
  final GroupMemberRole role;

  @override
  List<Object?> get props => [id, displayName, username, avatarUrl, role];

  GroupMemberModel copyWith({
    String? id,
    String? displayName,
    String? username,
    String? avatarUrl,
    GroupMemberRole? role,
  }) {
    return GroupMemberModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
    );
  }
}

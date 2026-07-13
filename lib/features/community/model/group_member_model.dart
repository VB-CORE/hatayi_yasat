import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

final class GroupMemberModel extends Equatable {
  const GroupMemberModel({
    required this.id,
    required this.displayName,
    required this.username,
    this.avatarUrl,
    this.role = GroupMemberRole.member,
  });

  factory GroupMemberModel.fromAppUser(AppUser user) {
    return GroupMemberModel(
      id: user.uid,
      displayName: user.displayName,
      username: user.email.split('@').first,
      avatarUrl: user.photoUrl,
    );
  }

  final String id;
  final String displayName;
  final String username;
  final String? avatarUrl;
  final GroupMemberRole role;

  /// Tartışmalar sekmesi için isim maskesi — "Saim Yıldırım" → "S••• Y•••••".
  String get maskedDisplayName {
    return displayName
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .map(
          (word) =>
              word.length <= 1 ? word : '${word[0]}${'•' * (word.length - 1)}',
        )
        .join(' ');
  }

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

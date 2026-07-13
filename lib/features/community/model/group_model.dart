import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_type.dart';

final class GroupModel extends Equatable {
  const GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    this.coverImageUrl,
    this.type = GroupType.open,
    this.createdAt,
    this.admins = const [],
    this.isCurrentUserAdmin = false,
  });

  final String id;
  final String name;
  final String description;
  final int memberCount;
  final String? coverImageUrl;
  final GroupType type;
  final DateTime? createdAt;
  final List<GroupMemberModel> admins;

  final bool isCurrentUserAdmin;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    memberCount,
    coverImageUrl,
    type,
    createdAt,
    admins,
    isCurrentUserAdmin,
  ];

  GroupModel copyWith({
    String? id,
    String? name,
    String? description,
    int? memberCount,
    String? coverImageUrl,
    GroupType? type,
    DateTime? createdAt,
    List<GroupMemberModel>? admins,
    bool? isCurrentUserAdmin,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      memberCount: memberCount ?? this.memberCount,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      admins: admins ?? this.admins,
      isCurrentUserAdmin: isCurrentUserAdmin ?? this.isCurrentUserAdmin,
    );
  }
}

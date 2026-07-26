import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';
import 'package:lifeclient/product/utility/constants/regex_types.dart';

part 'group_author_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class GroupAuthorModel extends Equatable {
  const GroupAuthorModel({
    this.uid = '',
    this.displayName = '',
    this.avatarUrl,
    this.role = GroupMemberRole.member,
  });

  const GroupAuthorModel.empty() : this();

  factory GroupAuthorModel.fromMember(GroupMemberModel member) {
    return GroupAuthorModel(
      uid: member.id,
      displayName: member.displayName,
      avatarUrl: member.avatarUrl,
      role: member.role,
    );
  }

  factory GroupAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$GroupAuthorModelFromJson(json);

  final String uid;
  final String displayName;
  final String? avatarUrl;
  @JsonKey(unknownEnumValue: GroupMemberRole.member)
  final GroupMemberRole role;

  bool get isAdmin => role == GroupMemberRole.admin;

  String get maskedDisplayName {
    return displayName
        .trim()
        .split(RegexTypes.whitespace)
        .where((word) => word.isNotEmpty)
        .map(
          (word) =>
              word.length <= 1 ? word : '${word[0]}${'•' * (word.length - 1)}',
        )
        .join(' ');
  }

  Map<String, dynamic> toJson() => _$GroupAuthorModelToJson(this);

  @override
  List<Object?> get props => [uid, displayName, avatarUrl, role];
}

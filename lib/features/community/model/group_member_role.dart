enum GroupMemberRole {
  member,
  admin;

  static GroupMemberRole fromString(String? value) =>
      GroupMemberRole.values.firstWhere(
        (e) => e.name == value,
        orElse: () => GroupMemberRole.member,
      );
}

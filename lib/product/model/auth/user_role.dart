enum UserRole {
  admin(1),
  user(2)
  ;

  const UserRole(this.value);

  final int value;

  static UserRole fromRoleType(int? value) => UserRole.values.firstWhere(
    (role) => role.value == value,
    orElse: () => UserRole.user,
  );
}

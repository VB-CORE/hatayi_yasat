enum UserRole {
  user,
  merchant,
  admin;

  static UserRole fromString(String? value) => UserRole.values.firstWhere(
        (e) => e.name == value,
        orElse: () => UserRole.user,
      );
}

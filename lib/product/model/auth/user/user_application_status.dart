enum UserApplicationStatus {
  pending(1),
  approved(2),
  denied(3);

  const UserApplicationStatus(this.value);

  final int value;

  static UserApplicationStatus fromValue(int? value) =>
      UserApplicationStatus.values.firstWhere(
        (status) => status.value == value,
        orElse: () => UserApplicationStatus.pending,
      );
}

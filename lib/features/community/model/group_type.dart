enum GroupType {
  open,
  closed;

  static GroupType fromString(String? value) => GroupType.values.firstWhere(
    (e) => e.name == value,
    orElse: () => GroupType.open,
  );
}

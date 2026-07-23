enum AppPermission {
  createGroup(1),
  createTopic(2)
  ;

  const AppPermission(this.value);

  final int value;

  static AppPermission? fromValue(int value) {
    for (final permission in AppPermission.values) {
      if (permission.value == value) return permission;
    }
    return null;
  }
}

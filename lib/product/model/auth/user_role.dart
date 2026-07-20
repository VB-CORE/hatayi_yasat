import 'package:collection/collection.dart';

enum UserRole {
  admin(1),
  user(2);

  const UserRole(this.code);

  final int code;

  static UserRole? fromCode(int? code) {
    if (code == null) return null;
    return UserRole.values.firstWhereOrNull((element) => element.code == code);
  }
}

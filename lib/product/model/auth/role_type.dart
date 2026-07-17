import 'package:collection/collection.dart';

enum RoleType {
  guest(1),
  user(2);

  const RoleType(this.code);

  final int code;

  static RoleType? fromCode(int? code) {
    if (code == null) return null;
    return RoleType.values.firstWhereOrNull((element) => element.code == code);
  }
}

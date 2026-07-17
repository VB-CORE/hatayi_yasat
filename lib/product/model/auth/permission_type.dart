import 'package:collection/collection.dart';

enum PermissionType {
  createGroups(1),
  createTopics(2);

  const PermissionType(this.code);

  final int code;

  static PermissionType? fromCode(int? code) {
    if (code == null) return null;
    return PermissionType.values.firstWhereOrNull(
      (element) => element.code == code,
    );
  }

  static List<PermissionType> parseList(List<dynamic>? raw) {
    if (raw == null) return const [];
    return raw
        .whereType<int>()
        .map(PermissionType.fromCode)
        .whereType<PermissionType>()
        .toList();
  }
}

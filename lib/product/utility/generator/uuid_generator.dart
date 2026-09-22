import 'package:uuid/uuid.dart';

final class UuidGenerator {
  const UuidGenerator._();

  static String generate() => const Uuid().v4();
}

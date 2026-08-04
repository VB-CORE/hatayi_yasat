import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

final class NonceGenerator {
  const NonceGenerator({Random? random}) : _random = random;

  final Random? _random;

  static const _charset =
      '0123456789'
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      'abcdefghijklmnopqrstuvwxyz'
      '-._~';

  static const _minLength = 22;

  String generate([int length = 32]) {
    if (length < _minLength) {
      throw ArgumentError.value(
        length,
        'length',
        'Nonce must be at least $_minLength characters',
      );
    }

    final random = _random ?? Random.secure();
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      buffer.write(_charset[random.nextInt(_charset.length)]);
    }
    return buffer.toString();
  }

  String sha256Hex(String input) =>
      sha256.convert(utf8.encode(input)).toString();
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeclient/product/utility/constants/regex_types.dart';
import 'package:lifeclient/product/utility/extension/time_of_day_extension.dart';

extension StringExtension on String {
  TimeOfDay get toTimeOfDay {
    return TimeOfDayExt.fromString(this);
  }

  /// Kullanıcı girdisini sadeleştirir:
  /// - Metnin başındaki ve sonundaki boşlukları kaldırır.
  /// - Satır başındaki ve sonundaki boşlukları kaldırır.
  /// - Birden fazla boşluğu tek boşluğa indirir.
  /// - Üç veya daha fazla satır sonunu iki satır sonuna indirir.
  String get normalize => replaceAll(RegexTypes.multipleSpaces, ' ')
      .replaceAll(RegexTypes.aroundLineBreaks, '\n')
      .replaceAll(RegexTypes.excessiveLineBreaks, '\n\n')
      .trim();

  /// Avatar fallback for names without a photo: the first letters of up to
  /// two words, upper-cased (e.g. 'Veli Bacik' -> 'VB').
  /// Returns '?' when the string is blank.
  String get initials {
    final parts = trim()
        .split(RegexTypes.whitespace)
        .where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    return parts.map((p) => p[0].toUpperCase()).take(2).join();
  }

  String get withHttps {
    if (startsWith('http')) {
      return this;
    } else {
      return 'https://$this';
    }
  }

  Future<void> copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: this));
  }
}

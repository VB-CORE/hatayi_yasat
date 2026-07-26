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
  /// [take] words (default 2), upper-cased (e.g. 'Veli Bacik' -> 'VB').
  /// Returns '?' when the string is blank.
  String initials({int take = 2}) {
    final parts = trim()
        .split(RegexTypes.whitespace)
        .where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    return parts.map((p) => p[0].toUpperCase()).take(take).join();
  }

  /// Short display form: first word + last initial (e.g. 'Veli Bacik' -> 'Veli B.').
  String get shortDisplayName {
    final name = trim();
    if (name.isEmpty) return '';

    final parts = name
        .split(RegexTypes.whitespace)
        .where((part) => part.isNotEmpty);

    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first;

    return '${parts.first} ${parts.last[0].toUpperCase()}.';
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

  /// Aramaya gitmeden önce minimum uzunluk kontrolü
  /// atıldıktan sonra en az 3 karakter. Yer aramasında ve şirket sheet'inde
  /// aynı eşik için kullanılır.
  bool get isValidSearchTerm => trim().length > 2;
}

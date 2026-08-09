import 'package:kartal/kartal.dart';

/// Çalışma saati etiketi: `"09:00 - 18:00"`.
abstract final class WorkingHours {
  static const String _separator = '-';

  /// İki uçtan biri boş ya da `null` ise `null` döner; çağıran yarım bir
  /// aralık ("09:00 - ") basmaz.
  static String? format(String? open, String? close) {
    if (open.ext.isNullOrEmpty || close.ext.isNullOrEmpty) return null;

    return '$open $_separator $close';
  }
}

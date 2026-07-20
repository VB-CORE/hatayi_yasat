import 'package:easy_localization/easy_localization.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

extension DateTimeExtensions on DateTime {
  /// Süresi dolmamış mı. → `true` / `false`
  bool get isNotExpired => DateTime.now().isBefore(this);

  /// Locale ay adı. → `'Temmuz'`
  String get getMonthName {
    final formatter = DateFormat('MMMM');
    return formatter.format(this);
  }

  /// 12s format. → `'02:30 PM'`
  String get getTime {
    final formatter = DateFormat('hh:mm a');
    return formatter.format(this);
  }

  /// Göreceli süre. → `'2 saat önce'`, `'Az önce'`
  String get timeAgo {
    final difference = DateTime.now().difference(this);
    if (difference.inDays >= 365) {
      return LocaleKeys.date_yearsAgo.tr(
        args: [(difference.inDays / 365).floor().toString()],
      );
    }
    if (difference.inDays >= 30) {
      return LocaleKeys.date_monthsAgo.tr(
        args: [(difference.inDays / 30).floor().toString()],
      );
    }
    if (difference.inDays >= 1) {
      return LocaleKeys.date_daysAgo.tr(args: [difference.inDays.toString()]);
    }
    if (difference.inHours >= 1) {
      return LocaleKeys.date_hoursAgo.tr(args: [difference.inHours.toString()]);
    }
    if (difference.inMinutes >= 1) {
      return LocaleKeys.date_minutesAgo.tr(
        args: [difference.inMinutes.toString()],
      );
    }
    return LocaleKeys.date_justNow.tr();
  }

  /// Gün başlangıcı 00:00. → `2026-07-20 00:00:00`
  DateTime get startOfDay => DateTime(year, month, day);

  /// 24s format. → `'14:30'`
  String get hm => DateFormat.Hm().format(this);

  /// Bugün/dün/tarih etiketi. → `'Bugün'`, `'Dün'`, `'20 Temmuz'`
  String get relativeDayLabel {
    final now = DateTime.now();
    final days = now.startOfDay.difference(startOfDay).inDays;

    return switch (days) {
      0 => LocaleKeys.date_today.tr(),
      1 => LocaleKeys.date_yesterday.tr(),
      _ when year == now.year => DateFormat.MMMMd().format(this),
      _ => DateFormat.yMMMd().format(this),
    };
  }
}

extension DateTimeHourAndMinuteExtensions on int {
  /// Tek haneli sayıya 0 ekler. → `'05'`
  String get beauty {
    if (this < 10) {
      return '0$this';
    }
    return toString();
  }
}

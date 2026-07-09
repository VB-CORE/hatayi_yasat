import 'package:easy_localization/easy_localization.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

extension DateTimeExtensions on DateTime {
  bool get isNotExpired => DateTime.now().isBefore(this);

  String get getMonthName {
    final formatter = DateFormat('MMMM');
    return formatter.format(this);
  }

  String get getTime {
    final formatter = DateFormat('hh:mm a');
    return formatter.format(this);
  }

  /// Relative time label like 'az önce', '5 dk önce', '2 saat önce'.
  String get timeAgo {
    final difference = DateTime.now().difference(this);
    if (difference.inMinutes < 1) return LocaleKeys.utils_justNow.tr();
    if (difference.inHours < 1) {
      return LocaleKeys.utils_minutesAgo.tr(
        args: [difference.inMinutes.toString()],
      );
    }
    if (difference.inDays < 1) {
      return LocaleKeys.utils_hoursAgo.tr(
        args: [difference.inHours.toString()],
      );
    }
    return LocaleKeys.utils_daysAgo.tr(args: [difference.inDays.toString()]);
  }
}

extension DateTimeHourAndMinuteExtensions on int {
  /// if the int is less than 10, 0 is prepended and return String
  /// example 5 -> '05'
  String get beauty {
    if (this < 10) {
      return '0$this';
    }
    return toString();
  }
}

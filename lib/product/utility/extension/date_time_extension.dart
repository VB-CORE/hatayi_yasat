import 'package:easy_localization/easy_localization.dart';

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

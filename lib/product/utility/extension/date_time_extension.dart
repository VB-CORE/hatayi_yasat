extension DateTimeExtensions on DateTime {
  bool get isNotExpired => DateTime.now().isBefore(this);
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

extension DateTimeExtensions on DateTime {
  bool get isNotExpired => DateTime.now().isBefore(this);
}

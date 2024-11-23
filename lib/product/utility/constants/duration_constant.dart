final class DurationConstant {
  DurationConstant._();

  /// Duration 0.5 second
  static const Duration durationLow = Duration(milliseconds: 500);

  /// Duration 1 second
  static const Duration durationNormal = Duration(seconds: 1);

  /// Duration 2 seconds
  static const Duration durationMedium = Duration(seconds: 2);

  /// Duration 3 seconds
  static const Duration durationLong = Duration(seconds: 3);

  /// Duration -1 days
  static const Duration durationDayMinusOne = Duration(days: -1);

  /// Duration 1 days
  static const Duration durationDayPlusOne = Duration(days: 1);
}

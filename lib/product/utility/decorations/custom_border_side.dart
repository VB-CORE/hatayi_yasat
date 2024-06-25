import 'package:flutter/material.dart';

@immutable

/// `CustomBorderSides` class defines static constants
/// for different stroke alignments of `BorderSide`
abstract final class CustomBorderSides {
  /// [ultraThin] is width: 0.1
  static const BorderSide ultraThin = BorderSide(width: 0.1);

  /// [veryThin] is width: 0.2
  static const BorderSide veryThin = BorderSide(width: 0.2);

  /// [thin] is width: 0.3
  static const BorderSide thin = BorderSide(width: 0.3);

  /// [regular] is width: 0.4
  static const BorderSide regular = BorderSide(width: 0.4);

  /// [medium] is width: 0.5
  static const BorderSide medium = BorderSide(width: 0.5);

  /// [thick] is width: 0.6
  static const BorderSide thick = BorderSide(width: 0.6);

  /// [veryThick] is width: 0.7
  static const BorderSide veryThick = BorderSide(width: 0.7);

  /// [ultraThick] is width: 0.8
  static const BorderSide ultraThick = BorderSide(width: 0.8);

  /// [maxThick] is width: 0.9
  static const BorderSide maxThick = BorderSide(width: 0.9);

  /// [superMaxThick] is width: 1.0
  static const BorderSide superMaxThick = BorderSide();

  /// [doubleUltraThin] is width: 2.0
  static const BorderSide doubleUltraThin = BorderSide(width: 2);
}

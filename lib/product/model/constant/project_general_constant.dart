import 'package:flutter/material.dart';

@immutable
final class ProjectGeneralConstant {
  const ProjectGeneralConstant._();

  /// Duration is 500 milliseconds.
  static const durationLow = Duration(milliseconds: 500);

  /// Duration is 1000 milliseconds.
  static const durationMedium = Duration(milliseconds: 1000);

  /// Duration is 1500 milliseconds.
  static const durationHigh = Duration(milliseconds: 1500);

  /// Duration is 2000 milliseconds.
  static const durationVeryHigh = Duration(seconds: 4);
}

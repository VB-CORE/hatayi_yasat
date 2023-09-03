import 'package:flutter/cupertino.dart';

@immutable
final class CustomRadius {
  const CustomRadius._();

  /// value is 4
  static const BorderRadius small = BorderRadius.all(Radius.circular(8));

  /// value is 12
  static const BorderRadius medium = BorderRadius.all(Radius.circular(12));

  /// value is 16
  static const BorderRadius large = BorderRadius.all(Radius.circular(16));

  /// value is 24
  static const BorderRadius extraLarge = BorderRadius.all(Radius.circular(24));

  // BorderRadius.all/
}

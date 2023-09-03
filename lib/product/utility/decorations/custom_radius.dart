import 'package:flutter/cupertino.dart';

@immutable
final class CustomRadius {
  const CustomRadius._();

  /// value is 4
  static const BorderRadiusGeometry small =
      BorderRadius.all(Radius.circular(8));

  /// value is 12
  static const BorderRadiusGeometry medium =
      BorderRadius.all(Radius.circular(12));

  /// value is 16
  static const BorderRadiusGeometry large =
      BorderRadius.all(Radius.circular(16));

  /// value is 24
  static const BorderRadiusGeometry extraLarge =
      BorderRadius.all(Radius.circular(24));
}

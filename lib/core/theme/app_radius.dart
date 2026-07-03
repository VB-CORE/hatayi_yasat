import 'package:flutter/widgets.dart';

abstract final class AppRadius {
  static const sm = 10.0;
  static const md = 12.0;
  static const lg = 14.0;
  static const xl = 16.0;
  static const xxl = 22.0;
  static const hero = 26.0;
  static const pill = 999.0;

  static BorderRadius get card => BorderRadius.circular(lg);
  static BorderRadius get sheet =>
      const BorderRadius.vertical(top: Radius.circular(xxl));
}

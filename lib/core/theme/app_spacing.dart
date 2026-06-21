import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 14.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;
  static const xxxl = 28.0;

  static const screenH = EdgeInsets.symmetric(horizontal: 16);
  static const screenV = EdgeInsets.symmetric(vertical: 16);
  static const screen = EdgeInsets.all(16);
  static const cardPad = EdgeInsets.all(14);
  static const listGap = 11.0;
}

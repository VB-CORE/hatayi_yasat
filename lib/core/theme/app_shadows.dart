import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const _navy = Color(0xFF0F2A47);

  static List<BoxShadow> card = [
    BoxShadow(
      color: _navy.withValues(alpha: 0.05),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> raised = [
    BoxShadow(
      color: _navy.withValues(alpha: 0.10),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> hero = [
    BoxShadow(
      color: _navy.withValues(alpha: 0.12),
      blurRadius: 40,
      offset: const Offset(0, 16),
    ),
  ];

  static List<BoxShadow> bottomBar = [
    BoxShadow(
      color: _navy.withValues(alpha: 0.08),
      blurRadius: 24,
      offset: const Offset(0, -6),
    ),
  ];

  static List<BoxShadow> popover = [
    BoxShadow(
      color: _navy.withValues(alpha: 0.18),
      blurRadius: 30,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> toast = [
    BoxShadow(
      color: _navy.withValues(alpha: 0.35),
      blurRadius: 40,
      offset: const Offset(0, 16),
    ),
  ];
}

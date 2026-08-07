import 'package:flutter/material.dart';

extension ColorX on Color {
  Color withOp(double opacity) => withValues(alpha: opacity);
}

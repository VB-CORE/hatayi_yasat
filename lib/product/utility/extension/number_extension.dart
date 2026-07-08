import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension NumberDecimalPatternExtension on int {
  String decimalPattern(BuildContext context) =>
      NumberFormat.decimalPattern(context.locale.toLanguageTag()).format(this);
}

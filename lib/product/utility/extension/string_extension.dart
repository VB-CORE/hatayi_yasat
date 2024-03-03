import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/extension/time_of_day_extension.dart';

extension StringExtension on String {
  TimeOfDay get toTimeOfDay {
    return TimeOfDayExt.fromString(this);
  }
}

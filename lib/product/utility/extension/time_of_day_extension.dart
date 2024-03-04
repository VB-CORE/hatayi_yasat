import 'package:flutter/material.dart';

extension TimeOfDayExt on TimeOfDay {
  String get stringValue {
    var hour = this.hour.toString();
    var minute = this.minute.toString();
    hour = _preProcessValue(hour);
    minute = _preProcessValue(minute);
    return '$hour:$minute';
  }

  String _preProcessValue(String value) {
    final intValue = int.parse(value);
    if (intValue < 10) {
      return '0$value';
    }
    return value;
  }

  static TimeOfDay fromString(String val) {
    final parts = val.split(':');
    if (parts.length != 2) throw Exception('Invalid time format');
    final hour = int.tryParse(parts.firstOrNull ?? '');
    final minute = int.tryParse(parts.lastOrNull ?? '');
    if (hour == null || minute == null) throw Exception('Invalid time format');
    return TimeOfDay(hour: hour, minute: minute);
  }

  bool isAfter(TimeOfDay time) {
    if (hour > time.hour) {
      return true;
    } else if (hour == time.hour && minute > time.minute) {
      return true;
    }
    return false;
  }
}

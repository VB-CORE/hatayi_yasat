import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/extension/time_of_day_extension.dart';

final class TimePickerController extends TextEditingController {
  TimeOfDay? _time;

  @override
  set value(TextEditingValue newValue) {
    final (hour, minute) = _parseTime(newValue.text);
    if (hour == null || minute == null) return;

    _time = TimeOfDay(hour: hour, minute: minute);
    super.value = newValue;
  }

  TimeOfDay? get time => _time;
  String? get hour => _time?.hour.toString();
  String? get minute => _time?.minute.toString();

  bool get isValid {
    if (_time == null) return false;
    return true;
  }

  (int? hour, int? minute) _parseTime(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return (null, null);
    final hour = int.tryParse(parts.firstOrNull ?? '');
    final minute = int.tryParse(parts.lastOrNull ?? '');
    return (hour, minute);
  }

  void setTime(TimeOfDay time) {
    _time = time;
    value = TextEditingValue(text: time.stringValue);
  }
}

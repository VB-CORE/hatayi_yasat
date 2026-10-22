import 'package:flutter/material.dart';
import 'package:lifeclient/product/package/calendar/calendar_model.dart';
import 'package:lifeclient/product/package/calendar/calendar_saver_io.dart'
    if (dart.library.js_interop) 'package:lifeclient/product/package/calendar/calendar_saver_web.dart';

@immutable
final class CalendarUtility {
  const CalendarUtility._();

  static Future<void> saveCalendar({required CalendarModel model}) =>
      const PlatformCalendarSaver().save(model);
}

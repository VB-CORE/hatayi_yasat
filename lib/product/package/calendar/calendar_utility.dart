import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/package/calendar/calendar_model.dart';

@immutable
final class CalendarUtility {
  const CalendarUtility._();

  static void saveCalendar({required CalendarModel model}) {
    final event = Event(
      title: model.title,
      description: model.description,
      startDate: model.expireDate,
      endDate: model.expireDate,
      iosParams: const IOSParams(reminder: Duration(minutes: 30)),
    );
    Add2Calendar.addEvent2Cal(event);
  }
}

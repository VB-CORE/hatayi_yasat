import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/calendar/calendar_model.dart';

@immutable
final class CalendarUtility {
  const CalendarUtility._();

  static void saveCalendar({required CalendarModel model}) {
    final event = Event(
      title: model.title,
      description: model.description,
      startDate: model.startDate,
      endDate: model.startDate,
    );
    Add2Calendar.addEvent2Cal(event);
  }
}

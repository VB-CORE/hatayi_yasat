import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:lifeclient/product/package/calendar/calendar_model.dart';
import 'package:lifeclient/product/package/calendar/calendar_saver.dart';

final class PlatformCalendarSaver implements CalendarSaver {
  const PlatformCalendarSaver();

  @override
  Future<void> save(CalendarModel model) async {
    final event = Event(
      title: model.title,
      description: model.description,
      startDate: model.expireDate,
      endDate: model.expireDate,
      iosParams: const IOSParams(reminder: CalendarModel.reminder),
    );
    await Add2Calendar.addEvent2Cal(event);
  }
}

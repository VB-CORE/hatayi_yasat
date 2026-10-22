import 'package:lifeclient/product/package/calendar/calendar_model.dart';

abstract interface class CalendarSaver {
  bool get isSupported;

  Future<void> save(CalendarModel model);
}

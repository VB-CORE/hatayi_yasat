import 'package:lifeclient/product/package/calendar/calendar_model.dart';

// Contract for the conditionally imported io/web implementations.
// ignore: one_member_abstracts
abstract interface class CalendarSaver {
  Future<void> save(CalendarModel model);
}

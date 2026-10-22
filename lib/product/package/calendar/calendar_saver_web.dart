import 'dart:async';
import 'dart:js_interop';

import 'package:lifeclient/product/package/calendar/calendar_ics.dart';
import 'package:lifeclient/product/package/calendar/calendar_model.dart';
import 'package:lifeclient/product/package/calendar/calendar_saver.dart';
import 'package:web/web.dart' as web;

final class PlatformCalendarSaver implements CalendarSaver {
  const PlatformCalendarSaver();

  static const _revokeDelay = Duration(seconds: 1);

  @override
  bool get isSupported => true;

  @override
  Future<void> save(CalendarModel model) async {
    final ics = CalendarIcs(model);
    final blob = web.Blob(
      [ics.content.toJS].toJS,
      web.BlobPropertyBag(type: CalendarIcs.mimeType),
    );
    final url = web.URL.createObjectURL(blob);
    final anchor = web.HTMLAnchorElement()
      ..href = url
      ..download = ics.fileName;
    web.document.body?.append(anchor);
    anchor
      ..click()
      ..remove();
    Timer(_revokeDelay, () => web.URL.revokeObjectURL(url));
  }
}

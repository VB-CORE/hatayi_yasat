import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/package/calendar/calendar_model.dart';

@immutable
final class CalendarIcs {
  const CalendarIcs(this.model);

  final CalendarModel model;

  static const mimeType = 'text/calendar;charset=utf-8';
  static const _lineBreak = '\r\n';
  static const _maxLineOctets = 75;
  static const _fallbackFileName = 'event';

  String get fileName {
    final safe = model.title.replaceAll(RegExp(r'[\\/:*?"<>|]'), '').trim();
    return '${safe.isEmpty ? _fallbackFileName : safe}.ics';
  }

  String get content {
    final date = _formatDate(model.expireDate);
    final lines = [
      'BEGIN:VCALENDAR',
      'VERSION:2.0',
      'PRODID:-//Hatayi Yasat//Calendar//TR',
      'CALSCALE:GREGORIAN',
      'BEGIN:VEVENT',
      'UID:$_uid',
      'DTSTAMP:${_formatDate(DateTime.now())}',
      'DTSTART:$date',
      'DTEND:$date',
      'SUMMARY:${_escape(model.title)}',
      'DESCRIPTION:${_escape(model.description)}',
      'BEGIN:VALARM',
      'ACTION:DISPLAY',
      'DESCRIPTION:${_escape(model.title)}',
      'TRIGGER:-PT${CalendarModel.reminder.inMinutes}M',
      'END:VALARM',
      'END:VEVENT',
      'END:VCALENDAR',
    ];
    return lines.map(_fold).join(_lineBreak) + _lineBreak;
  }

  String get _uid =>
      '${model.expireDate.millisecondsSinceEpoch}-${model.title.hashCode}'
      '@hatayiyasat';

  static String _formatDate(DateTime value) {
    final utc = value.toUtc();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${utc.year.toString().padLeft(4, '0')}${two(utc.month)}'
        '${two(utc.day)}T${two(utc.hour)}${two(utc.minute)}${two(utc.second)}Z';
  }

  static String _escape(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll(';', r'\;')
      .replaceAll(',', r'\,')
      .replaceAll(RegExp(r'\r?\n'), r'\n');

  static String _fold(String line) {
    final buffer = StringBuffer();
    var octets = 0;
    for (final rune in line.runes) {
      final char = String.fromCharCode(rune);
      final size = utf8.encode(char).length;
      if (octets + size > _maxLineOctets) {
        buffer.write('$_lineBreak ');
        octets = 1;
      }
      buffer.write(char);
      octets += size;
    }
    return buffer.toString();
  }
}

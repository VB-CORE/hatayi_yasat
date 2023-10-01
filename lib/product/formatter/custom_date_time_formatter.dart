import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/extension/date_time_extension.dart';

@immutable
final class CustomDateTimeFormatter {
  const CustomDateTimeFormatter._();

  /// The method is returning a formatted string representation of the given DateTime value. The string
  /// includes the day, month (translated to the appropriate language), and year of the DateTime value.
  static String formatValueTr(DateTime value) {
    final month = _Month.getByIndex(value.month).tr();
    return '${value.day} $month ${value.year} ${value.hour.beauty}:${value.minute.beauty}';
  }
}

enum _Month {
  jan(LocaleKeys.months_jan),
  feb(LocaleKeys.months_feb),
  mar(LocaleKeys.months_mar),
  apr(LocaleKeys.months_apr),
  may(LocaleKeys.months_may),
  jun(LocaleKeys.months_jun),
  jul(LocaleKeys.months_jul),
  aug(LocaleKeys.months_aug),
  sep(LocaleKeys.months_sep),
  oct(LocaleKeys.months_oct),
  nov(LocaleKeys.months_nov),
  dec(LocaleKeys.months_dec),
  ;

  const _Month(this.name);
  static String getByIndex(int code) {
    return _Month.values
        .firstWhere((element) => element.index == code - 1)
        .name;
  }

  final String name;
}

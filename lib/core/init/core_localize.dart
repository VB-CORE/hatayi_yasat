import 'package:flutter/material.dart';

enum AppLocale {
  en(Locale('en', 'US')),
  tr(Locale('tr', 'TR'));

  final Locale locale;
  const AppLocale(this.locale);
}

@immutable
class CoreLocalize {
  final initialPath = 'assets/translations';
  final startLocale = AppLocale.tr.locale;
  final List<Locale> supportedItems =
      AppLocale.values.map((e) => e.locale).toList();
}

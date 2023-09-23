import 'package:flutter/material.dart';

enum AppLocale {
  en(Locale('en', 'US')),
  tr(Locale('tr', 'TR'));

  const AppLocale(this.locale);

  final Locale locale;
}

@immutable
class CoreLocalize {
  final initialPath = 'assets/translations';
  final startLocale = AppLocale.tr.locale;
  final List<Locale> supportedItems =
      AppLocale.values.map((e) => e.locale).toList();
}

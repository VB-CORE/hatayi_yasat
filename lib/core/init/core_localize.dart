import 'package:flutter/material.dart';

@immutable
class CoreLocalize {
  final initialPath = 'assets/translations';
  final List<Locale> supportedItems = [
    const Locale('en', 'US'),
    const Locale('tr', 'TR'),
  ];
}

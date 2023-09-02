import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppBuilder {
  AppBuilder._();

  static Widget build(BuildContext context, Widget? child) {
    return ResponsiveBreakpoints.builder(
      child: child ?? const SizedBox(),
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }
}

import 'package:flutter/material.dart';

part 'items/onboard_keys.dart';
part 'items/splash_keys.dart';

typedef K = ApplicationKeys;

final class ApplicationKeys {
  const ApplicationKeys._();

  static final splashKeys = _SplashKeys._();
  static final onboardKeys = _OnboardKeys._();
}

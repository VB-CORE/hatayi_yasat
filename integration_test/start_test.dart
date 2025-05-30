import 'dart:io';

import 'package:patrol/patrol.dart';

import 'core/test_utility.dart';
import 'scenerios/onboard/onboard_test.dart';
import 'scenerios/splash/splash_test.dart';

void main() {
  patrolTest(
    'Initial Home Page Test',
    ($) async {
      await TestUtility.init();

      final splashTest = SplashTest($);
      final onboardTest = OnboardTest($);

      await splashTest.run();
      await onboardTest.run();

      if (!Platform.isMacOS) {
        await $.native.pressHome();
      }
    },
  );
}

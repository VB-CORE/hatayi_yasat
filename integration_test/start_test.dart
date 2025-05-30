import 'package:patrol/patrol.dart';

import 'core/test_utility.dart';
import 'flows/home/home_test.dart';
import 'flows/onboard/onboard_test.dart';
import 'flows/splash/splash_test.dart';

void main() {
  patrolTest(
    'Initial App Module Test',
    ($) async {
      await TestUtility.init();
      final homeTest = HomeTest($, next: null);
      final splashTest = SplashTest($, next: homeTest);
      final onboardTest = OnboardTest($, next: splashTest);
      await onboardTest.startFlow();
    },
  );
}

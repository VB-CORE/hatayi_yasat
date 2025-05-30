import 'package:patrol/patrol.dart';

import 'core/native_permission.dart';
import 'core/test_utility.dart';
import 'flows/onboard/onboard_test.dart';
import 'flows/splash/splash_test.dart';

void main() {
  patrolTest(
    'Initial Home Page Test',
    ($) async {
      await TestUtility.init();

      final splashTest = SplashTest($, next: null);
      final onboardTest = OnboardTest($, next: splashTest);
      await onboardTest.startFlow();
      final nativePermission = NativePermission(tester: $);
      await nativePermission.checkAndValidatePermission();
    },
  );
}

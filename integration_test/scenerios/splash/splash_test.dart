import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/init/keys/application_keys.dart';

import '../../core/base_test_scenario.dart';
import '../../helper/app_helper.dart';

final class SplashTest extends BaseTestScenario {
  SplashTest(super.tester);

  @override
  Future<bool> run() async {
    try {
      await $.pumpAndSettle();

      if (AppHelper.isOnboardCompleted()) {
        return true;
      }

      await $(K.splashKeys.logo).waitUntilVisible();

      final isLogoVisible = $(K.splashKeys.logo).exists;
      expect(isLogoVisible, isTrue, reason: 'logo is not visible');
      final isLoadingLottieVisible = $(K.splashKeys.loadingLottie).exists;
      expect(
        isLoadingLottieVisible,
        isTrue,
        reason: 'loading lottie is not visible',
      );
    } catch (e) {
      CustomLogger.showError<void>(e);
      return false;
    }
    return true;
  }

  @override
  Future<bool> waitAndCheckValid() async {
    await $(K.splashKeys.view).waitUntilVisible();
    return $(K.splashKeys.view).exists;
  }
}

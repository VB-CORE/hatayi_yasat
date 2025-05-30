import 'package:flutter_test/flutter_test.dart';
import 'package:lifeclient/product/init/keys/application_keys.dart';

import '../../core/base_test_scenario.dart';

final class OnboardTest extends BaseTestScenario {
  OnboardTest(super.tester);

  @override
  Future<bool> run() async {
    await $.pumpAndSettle();
    final isFullImageVisible = $(K.onboardKeys.fullImage).exists;
    expect(isFullImageVisible, isTrue, reason: 'full image is not visible');

    final isSkipButtonVisible = $(K.onboardKeys.skipButton).exists;
    expect(isSkipButtonVisible, isTrue, reason: 'skip button is not visible');

    await $(K.onboardKeys.skipButton).tap();

    return true;
  }

  @override
  Future<bool> waitAndCheckValid() async {
    await $(K.onboardKeys.fullImage).waitUntilVisible();
    return $(K.onboardKeys.fullImage).exists;
  }
}

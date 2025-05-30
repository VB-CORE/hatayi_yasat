import 'package:flutter_test/flutter_test.dart';
import 'package:lifeclient/product/init/keys/application_keys.dart';
import 'package:patrol/patrol.dart';

import '../../core/app_helper.dart';
import '../../core/base_test_scenario.dart';

final class OnboardTest extends BaseTestScenario {
  OnboardTest(super.$, {required super.next});

  @override
  Future<bool> run() async {
    await $.pumpAndSettle();
    final isFullImageVisible = $(K.onboardKeys.fullImage).exists;
    expect(isFullImageVisible, isTrue, reason: 'full image is not visible');

    final isSkipButtonVisible = $(K.onboardKeys.skipButton).exists;
    expect(isSkipButtonVisible, isTrue, reason: 'skip button is not visible');
    await $(K.onboardKeys.skipButton).tap(
      settleTimeout: const Duration(milliseconds: 100),
      settlePolicy: SettlePolicy.noSettle,
      visibleTimeout: const Duration(milliseconds: 100),
    );
    return true;
  }

  @override
  Future<bool> waitAndCheckValid() async {
    if (AppHelper.isOnboardCompleted()) {
      return false;
    }
    await $(K.onboardKeys.view).waitUntilVisible();
    return $(K.onboardKeys.view).exists;
  }
}

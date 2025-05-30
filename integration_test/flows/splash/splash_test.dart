import 'package:flutter_test/flutter_test.dart';
import 'package:lifeclient/product/init/keys/application_keys.dart';

import '../../core/base_test_scenario.dart';

final class SplashTest extends BaseTestScenario {
  SplashTest(super.$, {required super.next});

  @override
  Future<bool> run() async {
    await $(K.splashKeys.logo).waitUntilVisible();

    final isLogoVisible = $(K.splashKeys.logo).exists;
    expect(isLogoVisible, isTrue, reason: 'logo is not visible');
    final isLoadingLottieVisible = $(K.splashKeys.loadingLottie).exists;
    expect(
      isLoadingLottieVisible,
      isTrue,
      reason: 'loading lottie is not visible',
    );

    return true;
  }

  @override
  Future<bool> waitAndCheckValid() async {
    await $(K.splashKeys.view).waitUntilExists();
    return $(K.splashKeys.view).exists;
  }
}

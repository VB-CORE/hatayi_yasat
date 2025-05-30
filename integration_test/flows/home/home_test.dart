import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeclient/product/init/keys/application_keys.dart';

import '../../core/base_test_scenario.dart';
import '../../core/native_permission.dart';
import '../../core/test_safety_extension.dart';

final class HomeTest extends BaseTestScenario {
  HomeTest(super.$, {required super.next});

  final String _placeIdFirst = 'hsMC0cMtqFDRoxoLNcRF';
  @override
  Future<bool> run() async {
    final categoryArea = $(K.homeKeys.categoryArea);
    expect(categoryArea.exists, isTrue, reason: 'category area is not visible');
    final categoryCard = categoryArea.at(0);
    expect(categoryCard.exists, isTrue, reason: 'category card is not visible');
    await categoryCard.tap();
    await $(CloseButton).tap();
    await $.pumpAndTrySettle();

    /// impllement place card checker
    /// 1. check place card
    /// 2. press the card
    /// 3. drag to bottom
    /// 4. press home
    final placeAreaItem = $(K.homeKeys.placeCard(_placeIdFirst));
    await placeAreaItem.waitUntilVisible();
    expect(placeAreaItem.exists, isTrue, reason: 'place area is not visible');

    await placeAreaItem.tap();
    await $.pumpAndTrySettle();
    await $.native.pressBack();

    await $.tester.drag(
      $(K.homeKeys.homeScrollableArea),
      const Offset(0, -300),
    );
    await $.pumpAndTrySettle();
    await $.native.pressHome();
    return true;
  }

  @override
  Future<bool> waitAndCheckValid() async {
    await $.pumpAndTrySettle();

    final nativePermission = NativePermission(tester: $);
    await nativePermission.checkAndValidatePermission();

    await _handleWhatsNewSheet().safeVoid();
    final homeView = $(K.homeKeys.homeView);
    await homeView.waitUntilExists();
    return homeView.exists;
  }

  Future<void> _handleWhatsNewSheet() async {
    await $(K.generalKeys.whatsNewSheet).waitUntilExists();
    await $(CloseButton).tap();
    await $.pumpAndTrySettle();
  }
}

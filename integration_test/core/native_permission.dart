import 'dart:io';

import 'package:patrol/patrol.dart';

final class NativePermission {
  NativePermission({required this.tester});

  final PatrolIntegrationTester tester;

  Future<void> checkAndValidatePermission() async {
    final isCI = Platform.environment.containsKey('TEST_RUNNER') ||
        Platform.environment.containsKey('FIREBASE_TEST_LAB');
    if (isCI) return;
    if (Platform.environment.containsKey('CI')) return;

    final isFirebaseTestLab = Platform.environment['IS_TEST_LAB'] == 'true';
    if (isFirebaseTestLab) return;

    final isPermissionDialogVisible =
        await tester.native.isPermissionDialogVisible();
    if (isPermissionDialogVisible) {
      await tester.native.denyPermission();
      await tester.pumpAndSettle(duration: const Duration(seconds: 1));
    }
  }
}

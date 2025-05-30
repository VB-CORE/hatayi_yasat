import 'package:kartal/kartal.dart';
import 'package:patrol/patrol.dart';

abstract class BaseTestScenario {
  BaseTestScenario(this.$, {required this.next});
  final BaseTestScenario? next;
  final PatrolIntegrationTester $;

  Future<bool> run();
  Future<bool> waitAndCheckValid();
  Future<void> startFlow() async {
    try {
      final isVisible = await waitAndCheckValid();
      if (isVisible) {
        await run();
      }
    } catch (e) {
      CustomLogger.showError<void>(e);
    } finally {
      if (next != null) {
        await next!.startFlow();
      }
    }
  }
}

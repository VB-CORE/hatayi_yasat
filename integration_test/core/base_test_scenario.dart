import 'package:kartal/kartal.dart';
import 'package:patrol_finders/patrol_finders.dart';

abstract class BaseTestScenario {
  BaseTestScenario(this.$, {required this.next});
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

  final BaseTestScenario? next;

  final PatrolTester $;
}

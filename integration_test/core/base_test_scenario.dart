import 'package:patrol_finders/patrol_finders.dart';

abstract class BaseTestScenario {
  BaseTestScenario(this.$);
  Future<bool> run();
  Future<bool> waitAndCheckValid();

  final PatrolTester $;
}

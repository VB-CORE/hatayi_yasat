import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

extension TestSafety<T> on Future<T> {
  /// This method is used to safely run a future and return a nullable value.
  /// If the future throws an error, it will be caught and logged.
  Future<T?> safe() async {
    try {
      return await this;
    } catch (e) {
      CustomLogger.showError(e);
      return null;
    }
  }

  /// This method is used to safely run a future and return a void value.
  /// If the future throws an error, it will be caught and logged.
  Future<void> safeVoid() async {
    try {
      await this;
    } catch (e) {
      CustomLogger.showError(e);
    }
  }
}

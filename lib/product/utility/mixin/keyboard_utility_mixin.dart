import 'package:flutter/services.dart';

mixin KeyboardUtilityMixin {
  /// Close keyboard from system
  static Future<void> closeFromSystem() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeclient/product/package/text_input/submit_on_enter.dart';

final class PlatformSubmitOnEnter implements SubmitOnEnter {
  const PlatformSubmitOnEnter();

  @override
  bool isSubmitKey(KeyEvent event) {
    final key = event.logicalKey;
    final isEnter =
        key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter;
    return isEnter && !HardwareKeyboard.instance.isShiftPressed;
  }

  @override
  Widget wrap({required VoidCallback onSubmit, required Widget child}) {
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onKeyEvent: (node, event) {
        if (!isSubmitKey(event)) return KeyEventResult.ignored;
        if (event is KeyDownEvent) onSubmit();
        return KeyEventResult.handled;
      },
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

@immutable
final class KeyboardFocusControlWidget extends StatelessWidget {
  const KeyboardFocusControlWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus,
      child: child,
    );
  }

  void _unfocus() {
    final focused = FocusManager.instance.primaryFocus;
    if (focused is FocusScopeNode) return;
    focused?.unfocus();
  }
}

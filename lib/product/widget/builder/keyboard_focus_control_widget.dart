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
      child: child,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}

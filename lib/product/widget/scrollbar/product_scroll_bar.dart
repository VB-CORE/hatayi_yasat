import 'package:flutter/material.dart';

final class ProductScrollBar extends StatelessWidget {
  const ProductScrollBar({
    required this.child,
    this.thumbVisibility = true,
    this.controller,
    super.key,
  });

  /// [child] will have scrollbar appearance
  final Widget child;

  /// [thumbVisibility] indicates that scrollbar is visible always
  ///
  /// Default value is true
  final bool thumbVisibility;

  /// Pass the same [ScrollController] used by the scrollable [child] when
  /// it doesn't rely on the [PrimaryScrollController], otherwise the
  /// scrollbar can fail to find a valid scroll position.
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: thumbVisibility,
      controller: controller,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

final class ProductScrollBar extends StatelessWidget {
  const ProductScrollBar({
    required this.child,
    this.thumbVisibility = true,
    super.key,
  });

  /// [child] will have scrollbar appearance
  final Widget child;

  /// [thumbVisibility] indicates that scrollbar is visible always
  ///
  /// Default value is true
  final bool thumbVisibility;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: thumbVisibility,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

/// ListView with space between children
/// [children] is required
///
/// All: 20 padding with Bottom: 16
final class ListViewWithSpace extends StatelessWidget {
  const ListViewWithSpace({required this.children, super.key});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const PagePadding.all() + const PagePadding.onlyBottom(),
        child: Column(
          children: children
              .map(
                (e) => _ItemWithPadding(
                  isLast: e == children.lastOrNull,
                  child: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

final class _ItemWithPadding extends StatelessWidget {
  const _ItemWithPadding({
    required this.child,
    this.isLast = false,
  });

  final Widget child;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLast ? EdgeInsets.zero : const PagePadding.onlyBottom(),
      child: child,
    );
  }
}

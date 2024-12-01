import 'package:flutter/material.dart';

part 'tap_area_mixin.dart';

final class TapArea extends StatefulWidget {
  const TapArea({
    required this.child,
    required this.onTap,
    super.key,
    this.padding,
  });

  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  @override
  State<TapArea> createState() => _TapAreaState();
}

class _TapAreaState extends State<TapArea> with TapAreaMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => updateClicked(value: true),
      onTapCancel: () => updateClicked(value: false),
      onTap: () {
        updateClicked(value: false);
        widget.onTap.call();
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isTappedNotifier,
        builder: (context, isDown, child) {
          return Opacity(
            opacity: isDown ? .7 : 1,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

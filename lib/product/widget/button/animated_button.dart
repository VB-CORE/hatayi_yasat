import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    required this.isAnimated,
    required this.onPressed,
    required this.icon,
    super.key,
  });
  final bool isAnimated;
  final AsyncCallback onPressed;
  final AnimatedIconData icon;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin, _AnimatedButtonMixin {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: widget.icon,
        progress: animation,
      ),
      onPressed: () async {
        widget.isAnimated
            ? await controller.reverse()
            : await controller.forward();
        await widget.onPressed();
      },
    );
  }
}

mixin _AnimatedButtonMixin
    on State<AnimatedButton>, SingleTickerProviderStateMixin<AnimatedButton> {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Durations.short4,
    );
    animation = Tween<double>(begin: 1, end: 0).animate(controller);
  }
}

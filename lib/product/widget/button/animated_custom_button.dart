import 'package:flutter/material.dart';

/// Animated custom button
/// [firstIcon] is the first icon
/// [secondIcon] is the second icon
/// [isAnimated] is the animated state
/// [onPressed] is the callback function
final class AnimatedCustomButton extends StatelessWidget {
  const AnimatedCustomButton({
    required this.firstIcon,
    required this.secondIcon,
    required this.isAnimated,
    required this.onPressed,
    super.key,
  });
  final IconData firstIcon;
  final IconData secondIcon;
  final bool isAnimated;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: IconButton(
        icon: Icon(firstIcon),
        onPressed: onPressed,
      ),
      secondChild: IconButton(
        icon: Icon(secondIcon),
        onPressed: onPressed,
      ),
      crossFadeState:
          isAnimated ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: Durations.long1,
    );
  }
}

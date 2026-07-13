import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Custom shimmer widget with a gradient.
class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    required this.child,
    this.duration = const Duration(seconds: 3),
    super.key,
  });
  final Widget child;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: duration,
      child: child,
    );
  }
}

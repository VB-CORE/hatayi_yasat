import 'package:bounceable/bounceable.dart';
import 'package:flutter/material.dart';

class CustomBounceable extends StatelessWidget {
  const CustomBounceable({
    required this.child,
    this.onTap,
    this.scaleFactorOnTap = .95,
    super.key,
  });

  final Widget child;
  final void Function()? onTap;
  final double scaleFactorOnTap;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      scaleFactorOnTap: scaleFactorOnTap,
      child: child,
    );
  }
}

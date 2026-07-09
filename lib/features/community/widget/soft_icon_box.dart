import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

/// Soluk renkli zemin üzerinde ikon gösteren yumuşak kutu.
@immutable
final class SoftIconBox extends StatelessWidget {
  const SoftIconBox({
    required this.icon,
    required this.iconColor,
    this.backgroundColor,
    this.backgroundOpacity = 0.12,
    super.key,
  });

  final IconData icon;
  final Color iconColor;

  /// Verilmezse [iconColor] zemin tonu olarak kullanılır.
  final Color? backgroundColor;
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: (backgroundColor ?? iconColor).withValues(
          alpha: backgroundOpacity,
        ),
        borderRadius: CustomRadius.medium,
      ),
      child: Padding(
        padding: const PagePadding.allVeryLow(),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}

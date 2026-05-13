import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// V2 mozaik logo. Uses the new logo asset (deep navy mosaic ground +
/// coral / teal / olive tesserae) introduced in the V2 design.
class HyLogo extends StatelessWidget {
  const HyLogo({super.key, this.size = 32});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/hy_logo_v2.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}

/// Brand lockup — logo + wordmark with optional secondary city tag.
///
/// Mirrors the V2 design `HyLockup`: editorial DM Serif Display title with
/// an optional small Plus Jakarta Sans secondary line below it.
class HyLockup extends StatelessWidget {
  const HyLockup({
    super.key,
    this.size = 32,
    this.title = "Hatay'ı Yaşat",
    this.secondary,
    this.titleColor,
    this.secondaryColor,
  });

  final double size;
  final String title;
  final String? secondary;
  final Color? titleColor;
  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HyLogo(size: size),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: V2Typography.display(
                fontSize: size * 0.55,
                color: titleColor ?? ColorsCustom.navy,
              ),
            ),
            if (secondary != null) ...[
              const SizedBox(height: 3),
              Text(
                secondary!,
                style: TextStyle(
                  fontSize: size * 0.32,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: secondaryColor ?? ColorsCustom.coral,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Small uppercase signature label that precedes display headings.
///
/// Mirrors the V2 design `Eyebrow2` — used as the editorial micro-label
/// before DM Serif Display headlines on splash, hero sections, and
/// section dividers.
class Eyebrow extends StatelessWidget {
  const Eyebrow(
    this.text, {
    super.key,
    this.color = ColorsCustom.coral,
    this.fontSize = 11,
  });

  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: V2Typography.eyebrow(fontSize: fontSize, color: color),
    );
  }
}

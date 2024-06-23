import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Genral body title widget with titleSmall style.
/// Font size: 14
/// FontWeight: 600
final class GeneralBodySmallTitle extends StatelessWidget {
  const GeneralBodySmallTitle(
    this.value, {
    super.key,
    this.maxLines,
    this.fontWeight,
    this.textDecoration,
    this.color,
  });

  final String value;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleSmall?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w600,
        decoration: textDecoration,
        color: color,
      ),
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}

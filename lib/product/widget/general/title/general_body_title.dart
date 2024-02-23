import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general body title widget with headlineMedium style.
///
/// Params:
/// - [value] is the text that will be shown
/// - [maxLines] is the maximum number of lines for the text
/// - [fontWeight] is the font weight of the text
/// - [textDecoration] is the decoration of the text
/// - [color] is the color of the text
@immutable
final class GeneralBodyTitle extends StatelessWidget {
  const GeneralBodyTitle(
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
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w600,
        decoration: textDecoration,
        color: color,
      ),
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general body title widget with headlineMedium style.
///
/// Params:
/// - [value] is the text that will be shown
/// - [maxLines] is the maximum number of lines for the text
/// - [overflow] is the text overflow strategy
/// - [fontWeight] is the font weight of the text
/// - [textDecoration] is the decoration of the text
@immutable
final class GeneralBodyTitle extends StatelessWidget {
  const GeneralBodyTitle(
    this.value, {
    super.key,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.textDecoration,
  });

  final String value;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      maxLines: maxLines,
      overflow: overflow,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w600,
        decoration: textDecoration,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general body title widget with headlineMedium style.
final class GeneralBodyTitle extends StatelessWidget {
  const GeneralBodyTitle(
    this.value, {
    super.key,
    this.maxLines,
    this.fontWeight,
  });
  final String value;
  final int? maxLines;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}

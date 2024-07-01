import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general content(body) text widget with titleLarge style.
final class GeneralContentTitle extends StatelessWidget {
  const GeneralContentTitle({
    required this.value,
    this.fontWeight,
    this.maxLine,
    this.color,
    super.key,
  });

  final String value;
  final FontWeight? fontWeight;
  final int? maxLine;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleLarge?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color,
      ),
      maxLines: maxLine,
      overflow: maxLine == null ? null : TextOverflow.ellipsis,
    );
  }
}

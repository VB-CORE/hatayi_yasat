import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general content(body) description text widget with bodySmall style.
final class GeneralContentSmallTitle extends StatelessWidget {
  const GeneralContentSmallTitle({
    required this.value,
    this.fontWeight,
    this.maxLine,
    super.key,
    this.textAlign,
    this.color,
  });

  final String value;
  final FontWeight? fontWeight;
  final int? maxLine;
  final TextAlign? textAlign;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.labelSmall?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color,
      ),
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: maxLine == null ? null : TextOverflow.ellipsis,
    );
  }
}

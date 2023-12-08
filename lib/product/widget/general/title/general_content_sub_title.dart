import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general content(body) description text widget with bodyMedium style.
final class GeneralContentSubTitle extends StatelessWidget {
  const GeneralContentSubTitle({
    required this.value,
    this.fontWeight,
    this.maxLine,
    super.key,
    this.textAlign,
  });

  final String value;
  final FontWeight? fontWeight;
  final int? maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.bodyMedium?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}

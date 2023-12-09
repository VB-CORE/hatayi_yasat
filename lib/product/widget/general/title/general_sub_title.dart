import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general big title widget with headlineSmall style.
final class GeneralSubTitle extends StatelessWidget {
  const GeneralSubTitle({
    required this.value,
    super.key,
    this.fontWeight,
    this.maxLine,
  });

  final String value;
  final FontWeight? fontWeight;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.headlineSmall?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}

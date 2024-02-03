import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general description title text widget with headlineSmall style
final class GeneralDescriptionTitle extends StatelessWidget {
  const GeneralDescriptionTitle({
    required this.value,
    this.fontWeight,
    this.maxLine,
    super.key,
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

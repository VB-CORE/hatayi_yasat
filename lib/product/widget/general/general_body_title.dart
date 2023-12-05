import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general body title widget with titleMedium style.
final class GeneralBodyTitle extends StatelessWidget {
  const GeneralBodyTitle(this.value, {super.key, this.fontWeight});

  final String value;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}

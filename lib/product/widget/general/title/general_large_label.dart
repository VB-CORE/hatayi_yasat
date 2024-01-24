import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general big title widget with labelLarge style.
final class GeneralLargeLabel extends StatelessWidget {
  const GeneralLargeLabel(
    this.value, {
    super.key,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.labelLarge,
    );
  }
}

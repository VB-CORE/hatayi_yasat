import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general big title widget with headlineMedium style.
final class GeneralBigTitle extends StatelessWidget {
  const GeneralBigTitle(this.value, {super.key});
  final String value;
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general body title widget with headlineMedium style.
final class GeneralBodyTitle extends StatelessWidget {
  const GeneralBodyTitle(this.value, {super.key});
  final String value;
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

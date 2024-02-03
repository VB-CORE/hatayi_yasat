import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general big title widget with headlineMedium style.
///
/// Max line is 2.
/// Bold and max line.
@immutable
final class GeneralBigBoldMaxTitle extends StatelessWidget {
  const GeneralBigBoldMaxTitle(
    this.value, {
    super.key,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      maxLines: 2,
      style: context.general.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w900,
        color: context.general.colorScheme.primary,
      ),
    );
  }
}

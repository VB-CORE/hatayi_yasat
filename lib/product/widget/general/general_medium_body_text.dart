import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general body text widget with bodyMedium style.
final class GeneralMediumBodyText extends StatelessWidget {
  const GeneralMediumBodyText({
    required this.value,
    required this.isBold,
    super.key,
  });
  final String value;
  final bool isBold;
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.bodyMedium?.copyWith(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

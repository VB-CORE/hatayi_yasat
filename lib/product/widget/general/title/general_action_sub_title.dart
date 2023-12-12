import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This is a general action sub title widget with headlineSmall style, underline.
/// maxLines is 1 with fontWeight 500.
final class GeneralActionSubTitle extends StatelessWidget {
  /// This widget is clickable for action.
  ///
  /// [value] string is title.
  /// [onTapped] function is action.

  const GeneralActionSubTitle({
    required this.value,
    required this.onTapped,
    super.key,
  });

  final String value;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTapped,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Text(
        value,
        style: context.general.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

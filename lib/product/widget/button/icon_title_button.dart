import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// Icon and title button for all project
/// [onPressed] required VoidCallback
/// [icon] required IconData
/// [text] required String
final class IconTitleButton extends StatelessWidget {
  const IconTitleButton({
    required this.onPressed,
    required this.icon,
    required this.text,
    super.key,
  });
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
     
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: context.general.colorScheme.primary,
          ),
          const EmptyBox.smallWidth(),
          Text(
            text,
            style: context.general.textTheme.titleSmall?.copyWith(
              color: context.general.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

final class IconWithText extends StatelessWidget {
  const IconWithText({
    required this.icon,
    required this.title,
    this.color,
    super.key,
  });
  final IconData icon;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const PagePadding.onlyRightLow(),
          child: Icon(icon, color: color),
        ),
        Expanded(
          child: Text(
            title,
            style: context.general.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

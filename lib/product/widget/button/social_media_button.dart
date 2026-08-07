import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/spacer/dynamic_horizontal_spacer.dart';

final class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const HorizontalSpace.xxxSmall(),
          Text(title),
        ],
      ),
    );
  }
}

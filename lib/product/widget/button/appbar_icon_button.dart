import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppbarIconButton extends StatelessWidget {
  const AppbarIconButton({
    required this.iconData,
    required this.destination,
    super.key,
  });

  final IconData iconData;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.route.navigateToPage(destination),
      icon: Icon(iconData),
    );
  }
}

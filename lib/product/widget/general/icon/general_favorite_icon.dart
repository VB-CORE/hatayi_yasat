import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

final class GeneralFavoriteIcon extends StatelessWidget {
  const GeneralFavoriteIcon({
    required this.isFavorite,
    super.key,
  });

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium2,
      switchInCurve: Curves.easeInOutBack,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        key: ValueKey(isFavorite),
        color: isFavorite
            ? context.general.colorScheme.error
            : context.general.colorScheme.primary,
      ),
    );
  }
}

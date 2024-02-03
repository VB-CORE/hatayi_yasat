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
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
      color: isFavorite
          ? context.general.colorScheme.error
          : context.general.colorScheme.primary,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';

class AppRatingWidget extends StatelessWidget {
  const AppRatingWidget({
    required this.isReadOnly,
    this.onRatingUpdate,
    this.value = 0,
    this.itemSize = 28,
    super.key,
  });
  final bool isReadOnly;
  final double? value;
  final ValueChanged<double>? onRatingUpdate;
  final double itemSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: itemSize,
      initialRating: value ?? 0,
      glow: false,
      ignoreGestures: isReadOnly,
      unratedColor: ColorsCustom.lightGray,
      itemPadding: const PagePadding.generalIconLowAll(),
      itemBuilder: (context, _) => const Icon(
        AppIcons.star,
        color: ColorsCustom.gold,
      ),
      onRatingUpdate: (value) => onRatingUpdate?.call(value),
    );
  }
}

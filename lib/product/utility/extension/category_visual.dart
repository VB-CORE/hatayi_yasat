import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

/// Resolves a stable icon + accent color for a [CategoryModel] so category
/// chips and image-less place cards render with varied, brand-aligned visuals.
///
/// The taxonomy has no icon/color field, so we derive both from
/// [CategoryModel.value]. Swap [iconFor]/[accentFor] with a real mapping if the
/// backend later ships per-category assets.
final class CategoryVisual {
  const CategoryVisual._();

  static const IconData allIcon = Icons.grid_view_rounded;

  static const _icons = <IconData>[
    Icons.storefront_outlined,
    Icons.restaurant_outlined,
    Icons.local_cafe_outlined,
    Icons.hotel_outlined,
    Icons.fitness_center_outlined,
    Icons.school_outlined,
    Icons.local_hospital_outlined,
    Icons.shopping_bag_outlined,
    Icons.pets_outlined,
    Icons.spa_outlined,
  ];

  static const _accents = <Color>[
    AppColors.coral,
    AppColors.teal,
    AppColors.olive,
    AppColors.navy400,
    AppColors.gold300,
  ];

  static IconData iconFor(CategoryModel? category) {
    if (category == null) return allIcon;
    return _icons[category.value.abs() % _icons.length];
  }

  static Color accentFor(CategoryModel? category) {
    if (category == null) return AppColors.navy;
    return _accents[category.value.abs() % _accents.length];
  }
}

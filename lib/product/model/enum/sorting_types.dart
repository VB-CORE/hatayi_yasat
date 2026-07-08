import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum SortingTypes {
  newest(
    detail: LocaleKeys.sorting_time_newest,
    icon: Icons.arrow_downward_rounded,
    field: 'createdAt',
    descending: true,
  ),
  oldest(
    detail: LocaleKeys.sorting_time_oldest,
    icon: Icons.arrow_upward_rounded,
    field: 'createdAt',
    descending: false,
  ),
  aToZ(
    detail: LocaleKeys.sorting_alpha_aToZ,
    icon: Icons.sort_by_alpha_rounded,
    field: 'name',
    descending: false,
  ),
  zToA(
    detail: LocaleKeys.sorting_alpha_zToA,
    icon: Icons.sort_by_alpha_rounded,
    field: 'name',
    descending: true,
  );

  const SortingTypes({
    required this.detail,
    required this.icon,
    required this.field,
    required this.descending,
  });

  final String detail;
  final IconData icon;

  /// Firestore field this sort orders by.
  final String field;

  /// Order direction for [field].
  final bool descending;

  SortingTypes change() {
    return this == SortingTypes.newest
        ? SortingTypes.oldest
        : SortingTypes.newest;
  }
}

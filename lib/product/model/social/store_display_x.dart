import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Presentation-layer adapters over `StoreModel` so the new mosaic UI
/// (place card, place detail) can read display-shaped fields directly
/// from the real `life_shared` model without fork-modifying the package.
///
/// Defaults are chosen for V2 visuals when the underlying schema does
/// not yet carry the field (rating / reviewCount / distance / category
/// label / accent palette). When those columns ship, swap out the
/// fallback for the real value.
extension StoreModelDisplay on StoreModel {
  /// Whether the store is currently open. Computed naively from
  /// [openTime]/[closeTime] — falls back to `false` when the schedule
  /// strings are missing or unparseable.
  bool get isOpenNow {
    final open = openTime;
    final close = closeTime;
    if (open == null || close == null) return false;
    final now = TimeOfDay.now();
    final start = _parseHm(open);
    final end = _parseHm(close);
    if (start == null || end == null) return false;
    final nowMinutes = now.hour * 60 + now.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    if (endMinutes >= startMinutes) {
      return nowMinutes >= startMinutes && nowMinutes <= endMinutes;
    }
    return nowMinutes >= startMinutes || nowMinutes <= endMinutes;
  }

  /// "09:00 – 23:00" style label for the status pill / detail row.
  String get hoursLabel {
    final open = openTime;
    final close = closeTime;
    if (open == null && close == null) return '';
    if (open != null && close != null) return '$open – $close';
    return open ?? close ?? '';
  }

  /// Gradient accent pair used by the mosaic place card / hero. Cycles
  /// through the mosaic palette based on the category's numeric value
  /// so that places of the same category share a colour, but adjacent
  /// categories don't collide.
  List<Color> get displayAccent {
    final palette = <List<Color>>[
      [ColorsCustom.coral, ColorsCustom.gold],
      [ColorsCustom.teal, ColorsCustom.navy],
      [ColorsCustom.olive400, ColorsCustom.coral],
      [ColorsCustom.gold, ColorsCustom.teal],
      [ColorsCustom.navy, ColorsCustom.teal],
    ];
    final value = category?.value ?? 0;
    return palette[value.abs() % palette.length];
  }

  /// Material icon backing this place's category. Looked up by category
  /// value; falls back to `storefront` when there's no category row.
  IconData get displayIcon {
    const map = <int, IconData>{
      1: Icons.restaurant_rounded,
      2: Icons.local_cafe_rounded,
      3: Icons.account_balance_rounded,
      4: Icons.storefront_rounded,
      5: Icons.sports_gymnastics_rounded,
      6: Icons.school_rounded,
      7: Icons.medical_services_rounded,
      8: Icons.spa_rounded,
      9: Icons.pets_rounded,
      10: Icons.palette_rounded,
      11: Icons.local_florist_rounded,
    };
    return map[category?.value] ?? Icons.storefront_rounded;
  }

  /// Human-readable category label for chips, headers, and footers.
  String get categoryLabel => category?.name ?? 'Mekan';

  /// District / town display name. The schema stores [townCode] (int)
  /// rather than a string district. Higher layers should resolve the
  /// town code to a label via the regional helpers; until then expose
  /// the code as a stringified fallback.
  String get districtLabel => townCode == 0 ? '' : 'Town $townCode';

  /// Hard-coded distance fallback. Wire to a real geo computation when
  /// the user's location is available.
  String get distanceFallback => '—';

  /// Hard-coded rating fallback until reviews ship.
  double get ratingFallback => 4.6;

  /// Hard-coded review count fallback until reviews ship.
  int get reviewCountFallback => 0;
}

TimeOfDay? _parseHm(String input) {
  final parts = input.split(':');
  if (parts.length < 2) return null;
  final h = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  if (h == null || m == null) return null;
  return TimeOfDay(hour: h, minute: m);
}

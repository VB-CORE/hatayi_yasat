import 'package:flutter/widgets.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

/// `NewsFeedModel.type` alanı serbest metin (Firestore'dan gelen ham
/// kategori string'i); sabit bir enum yok. Bu extension sadece kart
/// üzerinde göstermek için etiket/renk türetir, veri katmanına dokunmaz.
extension NewsCategoryTypeX on String? {
  static const List<Color> _palette = [
    AppColors.teal,
    AppColors.olive600,
    AppColors.coral600,
    AppColors.gold,
  ];

  String? get newsCategoryLabel {
    final raw = this?.trim();
    if (raw == null || raw.isEmpty) return null;
    return raw
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  Color get newsCategoryColor {
    final raw = this;
    if (raw == null || raw.isEmpty) return AppColors.navy400;
    final hash = raw.codeUnits.fold<int>(0, (sum, unit) => sum + unit);
    return _palette[hash % _palette.length];
  }
}

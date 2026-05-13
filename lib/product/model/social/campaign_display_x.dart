import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Presentation-layer adapter over [CampaignModel] for the V2 mosaic
/// event card (date block + chips + going count). The schema carries
/// name/topic/description/expireDate/photo/coverPhoto; everything else
/// is a design-system fallback.
extension CampaignModelDisplay on CampaignModel {
  /// Two-letter month label (UPPERCASE TR) used in the date block.
  String get displayMonth {
    final d = expireDate;
    if (d == null) return '';
    const months = [
      'OCA',
      'ŞUB',
      'MAR',
      'NİS',
      'MAY',
      'HAZ',
      'TEM',
      'AĞU',
      'EYL',
      'EKİ',
      'KAS',
      'ARA',
    ];
    return months[d.month - 1];
  }

  /// Two-digit day label.
  String get displayDay {
    final d = expireDate;
    if (d == null) return '';
    return d.day.toString().padLeft(2, '0');
  }

  /// Three-letter weekday label in TR.
  String get displayWeekday {
    final d = expireDate;
    if (d == null) return '';
    const wd = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
    return wd[d.weekday - 1];
  }

  /// HH:mm time portion of [expireDate].
  String get displayTime {
    final d = expireDate;
    if (d == null) return '';
    return '${d.hour.toString().padLeft(2, '0')}:'
        '${d.minute.toString().padLeft(2, '0')}';
  }

  /// Accent colour rotated by document id.
  Color get displayAccent {
    final palette = <Color>[
      ColorsCustom.coral,
      ColorsCustom.teal,
      ColorsCustom.gold,
      ColorsCustom.olive400,
    ];
    final hash = documentId.hashCode.abs();
    return palette[hash % palette.length];
  }

  /// Category label for the badge — falls back to "Etkinlik".
  String get displayCategory => topic ?? 'Etkinlik';

  /// Hard-coded going-count fallback until the schema tracks RSVPs.
  int get displayGoingCount => 0;
}

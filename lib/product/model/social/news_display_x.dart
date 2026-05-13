import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Presentation-layer adapter over [NewsModel] for the V2 mosaic news
/// card (hero gradient, category badge, source line). The schema
/// currently carries title/content/image/dates; everything else is a
/// design-system fallback that screens can override.
extension NewsModelDisplay on NewsModel {
  /// Coral / teal / gold / olive accent rotated by the document id so
  /// adjacent news items don't share the same hero gradient.
  Color get displayAccent {
    final palette = <Color>[
      ColorsCustom.teal,
      ColorsCustom.coral,
      ColorsCustom.gold,
      ColorsCustom.olive400,
      ColorsCustom.navy,
    ];
    final hash = documentId.hashCode.abs();
    return palette[hash % palette.length];
  }

  /// Short, uppercase tag shown on the hero. Falls back to "GÜNDEM".
  String get displayTag => 'GÜNDEM';

  /// Source / author label for the footer line.
  String get displayAuthor => 'Hatay Haber';

  /// Compact "X saat önce" timestamp computed from [createdAt].
  String get displayTimeAgo {
    final ts = createdAt;
    if (ts == null) return '';
    final delta = DateTime.now().difference(ts);
    if (delta.inMinutes < 60) return '${delta.inMinutes} dk önce';
    if (delta.inHours < 24) return '${delta.inHours} saat önce';
    return '${delta.inDays} gün önce';
  }

  /// First paragraph of the body (truncated) for the news-card excerpt.
  String get displayExcerpt {
    final body = content ?? '';
    if (body.length <= 140) return body;
    return '${body.substring(0, 140).trimRight()}…';
  }
}

import 'package:flutter/material.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/widget/brand/status_pill.dart';

/// V2 mekan kartı — image-tile thumbnail (mosaic-tinted), name,
/// neighborhood, status pill, rating + distance footer.
class V2PlaceCard extends StatelessWidget {
  const V2PlaceCard({
    required this.place,
    super.key,
    this.onTap,
    this.saved = false,
    this.onSavedToggle,
  });

  final V2Place place;
  final VoidCallback? onTap;
  final bool saved;
  final VoidCallback? onSavedToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsCustom.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorsCustom.ink50),
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            children: [
              _Thumb(place: place),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsCustom.ink900,
                                    letterSpacing: -0.1,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${place.categoryLabel} · ${place.neighborhood}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: ColorsCustom.ink400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: onSavedToggle,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              saved
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              size: 18,
                              color: saved
                                  ? ColorsCustom.navy
                                  : ColorsCustom.ink400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          StatusPill(
                            isOpen: place.isOpen,
                            hours: place.hours,
                            size: StatusPillSize.sm,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 13,
                                color: ColorsCustom.gold,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                place.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: ColorsCustom.ink600,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '(${place.reviewCount})',
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: ColorsCustom.ink400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '· ${place.distance}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: ColorsCustom.ink400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.place});

  final V2Place place;

  @override
  Widget build(BuildContext context) {
    final colors = place.accent.length >= 2
        ? place.accent
        : [...place.accent, ColorsCustom.navy];
    return SizedBox(
      width: 96,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colors.first, colors.last],
              ),
            ),
          ),
          IgnorePointer(
            child: CustomPaint(painter: _MiniMosaic()),
          ),
          Center(
            child: Icon(
              V2SampleData.iconForCategory(place.category),
              size: 36,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMosaic extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.25);
    const tile = 12.0;
    for (double y = 4; y < size.height; y += tile) {
      for (double x = 4; x < size.width; x += tile) {
        if ((x ~/ tile + y ~/ tile) % 4 == 0) continue;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, tile - 4, tile - 4),
            const Radius.circular(2),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
